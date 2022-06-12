library(highcharter)
library(wesanderson)

build_chart <- function(data_ts) {
  # Wes Anderson palette - The Life Aquatic with Steve Zissou (2004)
  pal <- wes_palette(name = "Zissou1", n = 8, type = "continuous")

  chart <-
    highchart(type = "stock", theme = hc_theme_ggplot2()) %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Dólar compra")),
      hcaes(x = fecha, y = !!sym("Dólar compra")),
      type = "line",
      showInLegend = FALSE,
      color = pal[1],
      name = "Dólar compra",
      yAxis = 0
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Dólar venta")),
      hcaes(x = fecha, y = !!sym("Dólar venta")),
      type = "line",
      showInLegend = FALSE,
      color = pal[8],
      name = "Dólar venta",
      yAxis = 0
    )  %>%
    hc_add_yAxis(
      nid = 1L,
      title = list(text = "USD / UYU"),
      relative = 1
    ) %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Euro compra")),
      hcaes(x = fecha, y = !!sym("Euro compra")),
      type = "line",
      showInLegend = FALSE,
      color = pal[2],
      name = "Euro compra",
      yAxis = 1
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Euro venta")),
      hcaes(x = fecha, y = !!sym("Euro venta")),
      type = "line",
      showInLegend = FALSE,
      color = pal[7],
      name = "Euro venta",
      yAxis = 1
    )  %>%
    hc_add_yAxis(
      nid = 2L,
      title = list(text = "EUR / UYU"),
      relative = 1,
      sep = 1
    ) %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Real compra")),
      hcaes(x = fecha, y = !!sym("Real compra")),
      type = "line",
      showInLegend = FALSE,
      color = pal[3],
      name = "Real compra",
      yAxis = 2
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Real venta")),
      hcaes(x = fecha, y = !!sym("Real venta")),
      type = "line",
      showInLegend = FALSE,
      color = pal[6],
      name = "Real venta",
      yAxis = 2
    )  %>%
    hc_add_yAxis(
      nid = 3L,
      title = list(text = "BRL / UYU"),
      relative = 1,
      sep = 1
    ) %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Peso Argentino compra")),
      hcaes(x = fecha, y = !!sym("Peso Argentino compra")),
      type = "line",
      showInLegend = FALSE,
      color = pal[4],
      name = "Peso Argentino compra",
      yAxis = 2
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Peso Argentino venta")),
      hcaes(x = fecha, y = !!sym("Peso Argentino venta")),
      type = "line",
      showInLegend = FALSE,
      color = pal[5],
      name = "Peso Argentino venta",
      yAxis = 3
    )  %>%
    hc_add_yAxis(
      nid = 4L,
      title = list(text = "ARS / UYU"),
      relative = 1,
      sep = 1
    ) %>%
    hc_xAxis(title = list(text = "Fecha"), type = "date") %>%
    hc_rangeSelector(
      verticalAlign = "top",
      selected = 2,
      buttons = list(
        list(
          type = "week",
          count = 1,
          text = "1S",
          title = "Ver una semana"
        ),
        list(
          type = "month",
          count = 1,
          text = "1M",
          title = "Ver un mes"
        ),
        list(
          type = "month",
          count = 3,
          text = "3M",
          title = "Ver tres meses"
        ),
        list(
          type = "month",
          count = 6,
          text = "6M",
          title = "Ver seis meses"
        ),
        list(
          type = "year",
          count = 1,
          text = "1A",
          title = "Ver un año"
        ),
        list(
          type = "year",
          count = 2,
          text = "2A",
          title = "Ver dos años"
        ),
        list(
          type = "all",
          text = "Todo",
          title = "Ver todos los datos"
        )
      )
    ) %>%
    hc_navigator(
      outlineWidth = 1,
      series = list(
        color = pal[4],
        lineWidth = 1,
        fillColor = pal[4]
      )
    ) %>%
    hc_tooltip(crosshairs = TRUE,
               valueDecimals = 2,
               useHTML = TRUE) %>%
    hc_credits(
      enabled = TRUE,
      text = "Fuente: Instituto Nacional de Estadística (INE)",
      href = "https://www.ine.gub.uy/web/guest/cotizacion-de-monedas",
      style = list(fontSize = "10px")
    ) %>%
    hc_boost(enabled = TRUE)

  return(chart)
}
