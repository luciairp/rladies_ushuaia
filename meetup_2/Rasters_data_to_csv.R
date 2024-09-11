### Meet up - RLadies Ushuaia###
### 28 junio 2024 ###
### Extraer datos de imagenes satelitales a una tabla usando Terra - Sami####

rm(list=ls())
ls()

library(terra)
library(sf)
library(ggplot2)
#explorar paqute geodata.


#en caso de que no esten usando un proyecto, setear wd:
#wd <- "C:/Users/User/Documents/R-ladies/2024/meetup_2"

# Primer paso: convertir raster a .tiff
# rasters bajados de  https://oceandata.sci.gsfc.nasa.gov/api/file_search)

r1 <- rast("data_satelital/OCTUBRE_2019.L3m_MO_CHL_chlor_a_4km.nc")
writeRaster(r1, "data_satelital/OCTUBRE_2019.L3m_MO_CHL_chlor_a_4km.tiff", filetype = "GTiff")

r2 <- rast("data_satelital/OCTUBRE_2019.L3m_MO_SST4_sst4_4km.nc")
writeRaster(r2, "data_satelital/OCTUBRE_2019.L3m_MO_SST4_sst4_4km.tiff", filetype = "GTiff")

# Cargamos rasters .tiff
r_sst <- rast("data_satelital/OCTUBRE_2019.L3m_MO_SST4_sst4_4km.tiff")

r_chla <- rast("data_satelital/OCTUBRE_2019.L3m_MO_CHL_chlor_a_4km.tiff")

# los apilamos
climStack <- c(r_sst, r_chla)

###### extraccion de valores del raster a partir de coordenadas #######

# leer el archivo con las lat/long
puntos <- read.csv("ejemplo_PM.csv")

# convertir a un objeto sf
puntos_sf <- st_as_sf(puntos, coords = c("LONG", "LAT"), crs = 4326)

# extraer valores del raster usando buffer
buffer_4km_chla_sst <- extract(climStack, vect(puntos_sf), fun = mean, buffer = 4000, df = TRUE)

# juntar valores con las coordenadas
bioclimat <- cbind(puntos, buffer_4km_chla_sst)


# escribir la tabla en la memoria
write.csv(bioclimat, "extract_chla_sst/oct2019_sst_chla.csv", row.names = FALSE)
