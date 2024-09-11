### Meet up - RLadies Ushuaia###
### 28 junio 2024 ###
### Mapas base usando getNOAA y composicion con gglot2 - Sami ###

rm(list=ls())
ls()

### get base map from NOAA###

library(ggplot2)
library(ggspatial)
library(sf)
library(marmap)


pt.lim = data.frame(ylim=c(-57, -35), xlim=c(-75, -55))
pt.bbox <- st_bbox(c(xmin=pt.lim$xlim[1],
                     xmax=pt.lim$xlim[2],
                     ymin=pt.lim$ylim[1],
                     ymax=pt.lim$ylim[2]))
pt.baty = getNOAA.bathy(
  lon1 = pt.lim$xlim[1], 
  lon2 = pt.lim$xlim[2], 
  lat1 = pt.lim$ylim[1], 
  lat2 = pt.lim$ylim[2], resolution = 1)
summary(pt.baty)
plot(pt.baty)

# Base map
baty_plot <- ggplot() +
  geom_raster(data = pt.baty, aes(x = x, y = y, fill = z)) +
  scale_fill_etopo() +
  geom_contour(data = pt.baty, aes(x = x, y = y, z = z),
               breaks = c(0, -10, -20, -50, -100, -200, -1000), colour = "grey", linewidth = 0.2) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  coord_sf(xlim=c(-75, -55),ylim=c(-57, -35), expand = FALSE)
print(baty_plot)

####### Plot tracks + Base map ######
### Ejemplo track
tabla1<-read.csv("ejemplo_PM.csv",header=T)
str(tabla1)

# Transform gls points to sf object

puntos_sf <- st_as_sf(tabla1, coords = c("LONG", "LAT"), crs = 4326)

# puntos + mapa  base

  baty_plot +
  geom_sf(data = puntos_sf) +
  annotation_scale(location = "bl") +
  coord_sf(xlim=c(-75, -55),ylim=c(-57, -35), expand = FALSE) +
  #theme(axis.text = element_text(size = 10))+
  theme(axis.title = element_blank())





