library(dplyr)
library(here)
library(lubridate)
library(readxl)
library(stringr)
library(tidyr)
library(tsibble)


format_data <- function(write = TRUE) {
  message("Procesando archivo descargado del INE...")
  data <- suppressWarnings(
    suppressMessages(
      read_excel(
        here("data", "cotizaciones.xlsx"),
        col_names = FALSE,
        skip = 8,
        progress = TRUE
      ) %>%
        select_if(~ !all(is.na(.))) %>%
        dplyr::rename(
          "día" = ...1,
          "mes" = ...2,
          "año" = ...3,
          "Dólar compra" = ...4,
          "Dólar venta" = ...5,
          "Dólar eBROU compra" = ...7,
          "Dólar eBROU venta" = ...8,
          "Euro compra" = ...10,
          "Euro venta" = ...11,
          "Peso Argentino compra" = ...13,
          "Peso Argentino venta" = ...14,
          "Real compra" = ...16,
          "Real venta" = ...17
        ) %>%
        fill(mes, año, .direction = "down") %>%
        mutate(mes = str_trim(str_sub(mes, 1, 3))) %>%
        mutate(
          mes = case_when(
            mes == "Ene" ~ "Jan",
            mes == "Abr" ~ "Apr",
            mes == "Ago" ~ "Aug",
            mes == "Set" ~ "Sep",
            mes == "Dic" ~ "Dec",
            TRUE ~ mes
          )
        ) %>%
        mutate(fecha = ymd(
          str_glue(
            "{año}-{mes}-{día}",
            año = año,
            mes = mes,
            día = día
          ),
          locale = "es_UY.UTF-8"
        )) %>%
        select(-`día`, -mes, -`año`) %>%
        mutate_if(is.character, as.double) %>%
        filter(!is.na(fecha))
    )
  )

  data_ts <-
    data %>%
    distinct(.keep_all = TRUE) %>%
    as_tsibble(index = fecha) %>%
    fill_gaps() %>% # fill gaps in time series index
    tidyr::fill(names(.), .direction = "down") # fill data from previous available data

  date_from <- min(data_ts$fecha)
  date_to <- max(data_ts$fecha)
  message(str_glue("Observaciones desde {date_from} a {date_to}."))

  # Write to file
  if (write) {
    if (!dir.exists("output")) {
      dir.create("output")
    }
    file_name <- "cotizaciones_processed.csv"
    message(str_glue("Guardando datos en archivo '{file_name}'."))
    readr::write_csv(x = data_ts, file = here("output", file_name))
  }

  return(data_ts)

}

# Process all raw data
format_data(write = TRUE)
