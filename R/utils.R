library(highcharter)
library(wesanderson)


get_yaxis_options <-
  function(axis_title = "USD / UYU",
           top = "0%",
           height = "20%",
           x = -20) {
    options = list(
      top = top,
      height = height,
      opposite = FALSE,
      showLastLabel = TRUE,
      allowDecimals = FALSE,
      labels = list(
        align = "right",
        x = x,
        distance = 0,
        format = "{value}"
      ),
      title = list(text = axis_title,
                   x = x * 0.006),
      startOnTick = FALSE,
      endOnTick = TRUE
    )
    return(options)
  }

get_empty_space <- function(top = "20%", height = "5%") {
  options <- list(top = top,
                  height = height)
  return(options)
}

build_chart <- function(data_ts) {
  # Wes Anderson palette - The Life Aquatic with Steve Zissou (2004)
  pal <- wes_palette(name = "Zissou1", n = 8, type = "continuous")

  chart <-
    highchart(type = "stock", theme = hc_theme_elementary()) %>%
    hc_chart(marginLeft = 80, marginRight = 200) %>%
    hc_yAxis_multiples(
      get_yaxis_options(
        "USD / UYU",
        top = "0%",
        height = "20%",
        x = -10
      ),
      get_empty_space(top = "20%", height = "5%"),
      get_yaxis_options(
        "EUR / UYU",
        top = "25%",
        height = "20%",
        x = 35
      ),
      get_empty_space(top = "45%", height = "5%"),
      get_yaxis_options(
        "BRL / UYU",
        top = "50%",
        height = "20%",
        x = 45
      ),
      get_empty_space(top = "70%", height = "5%"),
      get_yaxis_options(
        "ARS / UYU",
        top = "75%",
        height = "20%",
        x = 60
      ),
      get_empty_space(top = "95%", height = "5%")
    ) %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Dólar compra")),
      hcaes(x = fecha, y = !!sym("Dólar compra")),
      type = "line",
      color = pal[1],
      name = "Dólar compra",
      yAxis = 0
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Dólar venta")),
      hcaes(x = fecha, y = !!sym("Dólar venta")),
      type = "line",
      color = pal[8],
      name = "Dólar venta",
      yAxis = 0
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Dólar eBROU compra")),
      hcaes(x = fecha, y = !!sym("Dólar eBROU compra")),
      type = "line",
      color = pal[1],
      name = "Dólar eBROU compra",
      yAxis = 0
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Dólar eBROU venta")),
      hcaes(x = fecha, y = !!sym("Dólar eBROU venta")),
      type = "line",
      color = pal[8],
      name = "Dólar eBROU venta",
      yAxis = 0
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Euro compra")),
      hcaes(x = fecha, y = !!sym("Euro compra")),
      type = "line",
      color = pal[2],
      name = "Euro compra",
      yAxis = 2
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Euro venta")),
      hcaes(x = fecha, y = !!sym("Euro venta")),
      type = "line",
      color = pal[7],
      name = "Euro venta",
      yAxis = 2
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Real compra")),
      hcaes(x = fecha, y = !!sym("Real compra")),
      type = "line",
      color = pal[3],
      name = "Real compra",
      yAxis = 4
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Real venta")),
      hcaes(x = fecha, y = !!sym("Real venta")),
      type = "line",
      color = pal[6],
      name = "Real venta",
      yAxis = 4
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Peso Argentino compra")),
      hcaes(x = fecha, y = !!sym("Peso Argentino compra")),
      type = "line",
      color = pal[4],
      name = "Peso Argentino compra",
      yAxis = 6
    )  %>%
    hc_add_series(
      data = data_ts %>% select(fecha, !!sym("Peso Argentino venta")),
      hcaes(x = fecha, y = !!sym("Peso Argentino venta")),
      type = "line",
      color = pal[5],
      name = "Peso Argentino venta",
      yAxis = 6
    )  %>%
    hc_xAxis(title = list(text = "Fecha"), type = "date") %>%
    hc_rangeSelector(
      verticalAlign = "top",
      selected = 3,
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
    hc_legend(
      enabled = TRUE,
      layout = "proximate",
      align = "right",
      floating = FALSE
    ) %>%
    hc_tooltip(
      crosshairs = TRUE,
      shared = TRUE,
      valueDecimals = 2,
      useHTML = TRUE
    ) %>%
    hc_credits(
      enabled = TRUE,
      text = "Fuente: Instituto Nacional de Estadística (INE)",
      href = "https://www.ine.gub.uy/web/guest/cotizacion-de-monedas",
      style = list(fontSize = "10px")
    ) %>%
    hc_boost(enabled = TRUE)

  return(chart)
}
