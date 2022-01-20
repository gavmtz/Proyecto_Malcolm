
library(readr)
library(dplyr)
library(ggplot2)
library(forcats)
library(ggbeeswarm)
library(paletteer)
library(ggimage)
library(png)
library(grid)
library(sysfonts)
library(extrafont)

# dataset 
malc_ep <- read_csv("data/malcolm_episodios_puntaje.csv")

# Resume las columnas en Temporada 'X' para ser usado en el eje x
malc_ep <- malc_ep %>% 
  mutate(num_temporada = paste0('Temporada ',Temporada))

# Ajusta el tema
theme_set(theme_minimal())
theme <- theme_update(text = element_text(family = "Consolas",
                                          size = 9),
                      plot.title = element_text("Consolas",
                                                size = 18,
                                                color = "gray20"),
                      plot.subtitle = element_text("Consolas",
                                                   size = 12,
                                                   color = "gray20"),
                      plot.caption = element_text("Consolas",
                                                  size = 9,
                                                  color = "gray20"),
                      plot.title.position = "plot",
                      axis.text = element_text(size = 9),
                      axis.title.x = element_text(size = 9),
                      axis.line.x = element_line(color = "gray80"),
                      axis.line.y = element_line(color = "gray80"),
                      panel.grid.minor = element_blank(),
                      plot.margin = margin(15, 30, 15, 15))


# Grafico base
base <- ggplot(
  data = malc_ep,aes(fct_rev(num_temporada),
                     calificacion))+
  geom_blank() +
  labs(title = "Episodios de Malcolm in the Middle",
       subtitle = "Puntaje en imdb.com",
       x = "", y = NULL,
       caption = "github.com/gavmtz") + 
  # introduce linea de color que resalta los demas rangos
  # geom_rect(data = malc_ep, xmin = 1.0,
  #           xmax = 1.5, ymin = 6, ymax = 10,
  #           fill = "gray75",alpha = 0.1) +
  geom_quasirandom(aes(fct_rev(num_temporada),
                       calificacion,
                       color = num_temporada),
                   size = 4, alpha = 0.6,
                   show.legend = FALSE) +
  scale_y_continuous(limits = c(6,10),
                     expand = c(0,0)) +
  scale_color_paletteer_d("ggsci::default_jco") +
  coord_flip()

# Episodios con menor calificacion
# T3_E19 Terapia (Escenas pasadas)
# T4_E17 Escenas pasadas

# Episodios con mayor calificacion
# T2_E20 Boliche
# T7_E22 Graduacion

# lee la direccion de la imagen
grad <- readPNG('img/grad.png')
boli <- readPNG('img/boliche.png')
ter <- readPNG('img/terapia.png')
jam <- readPNG('img/jamie.png')

# transforma la imagen
malc =  rasterGrob(grad, interpolate=TRUE)
cony = rasterGrob(boli, interpolate=TRUE)
haL =  rasterGrob(jam, interpolate=TRUE)
tri =  rasterGrob(ter, interpolate=TRUE)

# direcciones de las flechas
flechas <- tribble(
  ~label,       ~y1,    ~y2,   ~x1,   ~x2,
  #  dist_in, dist_fin, T_in_alt, T_f_alt
  "Terapia",    6.1,   6.3,    5.9,   5.0,
  "Jamie",      6.3,   6.5,    3.2,   3.9,
  "Boliche",    9.5,   9.3,    7.2,   6.2,
  "Graduacion", 9.5,   9.1,    2.0,   1.2)

# curvas
base + geom_curve(data = flechas,
                  aes(x = x1, y = y1,
                      xend = x2, yend = y2,
                      colour = "label"),
                  arrow = arrow(length = unit(0.07,"inch")),
                  curvature = 0.3,
                  show.legend = FALSE,
                  color = "grey70") +
  # Malcolm en graduación
  annotation_custom(grob = malc, xmin = 1.8,
                    xmax = 2.6, ymin = 9.5,
                    ymax = 9.9 ) +
  # malcolm cony
  annotation_custom(grob = cony, xmin = 6.7,
                    xmax = 7.5, ymin = 9.4,
                    ymax = 9.9) +
  # Terapia
  annotation_custom(grob = tri, xmin = 6,
                    xmax = 6.9, ymin = 5.9,
                    ymax = 6.6) +
  # Llega Jamie
  annotation_custom(grob = haL, xmin = 2.4,
                    xmax = 3.3, ymin = 6.1,
                    ymax = 6.6) +
  # texto de los capitulos
  annotate("text", x = 2.3, y = 6.0, 
           label = "Escenas pasadas",
           hjust = 0,
           family = "Consolas") +
  annotate("text", x = 7.1, y = 6.0,
           label = "Terapia",
           hjust = 0,
           family = "Consolas") +
  annotate("text", x = 6.0, y = 9.475,
           label = "Boliche(Connie) \nlol", 
           hjust = 0,
           family = "Consolas") +
  annotate("text", x = 1.5, y = 9.6,
           label = "Graduación",
           hjust = 0,
           family = "Consolas")

# Guarda la imagen
ggsave("Malcolm_episodios.png",
       device = "png",
       width = 12,
       height = 10,
       dpi = 300)
