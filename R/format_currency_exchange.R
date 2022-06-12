library(dplyr)
library(here)
library(lubridate)
library(readxl)
library(stringr)
library(tidyr)
library(tsibble)

file <- "cotizaciones.xlsx"

# Load data from saved file
data <- suppressWarnings(
  suppressMessages(
    read_excel(
      here("data", file),
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
