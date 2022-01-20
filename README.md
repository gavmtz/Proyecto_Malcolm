## Calificaciones en IMDb.com de todos los episodios de 'Malcolm el de en medio' (2000 - 2006)

El 19 de enero de 2022 obtuve mediante web scraping el listado detallado de los episodios de la serie. Los pasos a seguir se encuentran detallados en el siguiente enlace [Step-by-step](https://isabella-b.com/blog/scraping-episode-imdb-ratings-tutorial/).

El código fue adaptado del ejemplo que realizó [Isabella](https://isabella-b.com/).

### El repositorio contiene el código en R como se muestra a continuación:

`grafico_Malcolm.R` - Donde muestra paso a paso la realización del gráfico.

### Archivo de datos

Estructura del archivo:   

**Temporada** - `Temporada` = `col_double()`

**Número de episodio** - `episodio_numero` = `col_double()`

**Título** - `titulo` = `col_character()`

**Fecha de emisión** - `fecha_emision` = `col_date(format = "")`

**Calificación en IMBd** - `calificacion` = `col_double()`

**Votos totales** - `votos_totales` = `col_character()`

**Descripción** - `descripcion` = `col_character`
