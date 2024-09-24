
# Map with a cat ----------------------------------------------------------

library(magick)
library(ggimage)
library(patchwork)
library(figpatch)
library(ggplot2)

# Cat ---------------------------------------------------------------------

oiia <- "data/oiia.jpeg"


# Create header -----------------------------------------------------------

header_oiia <- 
image_crop(
image_annotate(
  image_border(image_scale(image_read(oiia), "200"),
               geometry = "1100 x 10",
               color = "white"),
               text = "Map of USA if it was", size = 120, color = "black",
  gravity ="Center",
  location = "-650"
),
"1300x250"
)

image_write(header_oiia, path = "data/header_oiia.png", format = "png")

# Map of USA --------------------------------------------------------------

us_states <- map_data("state")

map_usa <-
  ggplot(us_states) +
  geom_polygon(aes(x = long, y = lat, group = group),
               fill = "transparent",
               color = "black") +
  theme_void()


# Add cat -----------------------------------------------------------------

oiia_usa <- ggbackground(map_usa, oiia)

# Paste  ------------------------------------------------------------------

oiia_fig_header <- fig("data/header_oiia.png", aspect.ratio = "free")

final_oiia_map <- wrap_plots(oiia_fig_header , oiia_usa, ncol = 1)

final_oiia_map
