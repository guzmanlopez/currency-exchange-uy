library(dplyr)
library(here)
library(httr)
library(rvest)
library(xml2)

save_currency_exchange_data = function(res) {
  file <- here("data", "cotizaciones.xlsx")
  zz <- file(file, "wb")
  writeBin(res$content, zz)
  close(zz)
  return(file)
}

# Download data from INE and write to a file
set_config(config(ssl_verifypeer = 0L))

url <-
  read_html(GET("https://www.ine.gub.uy/web/guest/cotizacion-de-monedas")) %>%
  html_node(".pull-right > a:nth-child(1)") %>%
  html_attr("href")

res <-
  GET(url = url, httr::timeout(60))

file <- save_currency_exchange_data(res)
