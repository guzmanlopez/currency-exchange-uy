[![Currency Exchange UY](https://github.com/guzmanlopez/currency_exchange_uy/actions/workflows/main.yaml/badge.svg?branch=main)](https://github.com/guzmanlopez/currency_exchange_uy/actions/workflows/main.yaml) [![pages-build-deployment](https://github.com/guzmanlopez/currency_exchange_uy/actions/workflows/pages/pages-build-deployment/badge.svg?branch=main)](https://github.com/guzmanlopez/currency_exchange_uy/actions/workflows/pages/pages-build-deployment)

# Currency Exchange UY

El objetivo de este código es descargar periódicamente (24 horas) los datos de distintas monedas publicados por el Intituto Nacional de Estadística ([INE](https://www.ine.gub.uy/), Uruguay) para su fácil acceso y visualización por parte de la comunidad.

## Panel interactivo

Para ver todos los datos en figuras interactivas por estaciones meteorológicas y mareográficas ingresar al [Panel interactivo](https://guzmanlopez.github.io/currency_exchange_uy/).

## Descarga de los datos

A continuación se detallan tres opciones de cómo descargarse todos los datos de este repositorio descargados hasta el momento:

### Opción 1

Utilizando la página web estática generada por este sitio: 

- Ingresar a [Panel interactivo - Descargar datos](https://guzmanlopez.github.io/currency_exchange_uy/#descargar-datos).

- Luego elegir formato CSV (texto plano separado por comas) o Excel haciendo clic en las opciones que se presentan arriba a la izquierda. 

### Opción 2

Descargarse el archivo comprimido de todo el repositorio desde aquí: [main.zip](https://github.com/guzmanlopez/currency_exchange_uy/archive/refs/heads/main.zip)

### Opción 3

Utilizando la terminal, clonar el repositorio:

```{sh}
# Utilizando HTTPS
git clone https://github.com/guzmanlopez/currency_exchange_uy.git

# O utilizando SSH
git clone git@github.com:guzmanlopez/currency_exchange_uy.git
```

Para actualizar los últimos datos:

```{sh}
# En el directorio del repositorio previamente clonado:
git pull
```

