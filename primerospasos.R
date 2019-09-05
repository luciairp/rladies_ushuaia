###################################################
#                 primeros pasos                  #
#         1° encuentro R-Ladies Ushuaia           #
#                   22/05/2018                    #
###################################################


#que objetos hay definidos
ls()
#borrar todos los objetos definidos
rm(list=ls())

#defino directorio de donde va a levantar datos
#con instruccion
setwd("E:/Particion d/Docs/cosas R/R-ladies/ch Ushuaia/Meetup 1 220518/material")
#setwd("ruta hasta la carpeta donde esta el archivo")
#o... navegando por menues: session--> set wd -->choose dir

#cargar datos desde txt o csv
datos<-read.table("basevinchucasRLadiesUsh.txt",header=TRUE,dec=",")
# datos<-read.csv("A.csv",header=T,sep=";",dec=",")
# estructura:
# nombre del objeto que se le asigna a <--
# tipo de archivo: txt o csv
# ("nombre.extension",caracteristicas)
# tienen nombre las columnas? separador de variables? separador decimal?


#veo datos
datos
head(datos)#primera parte
names(datos)#nombres de columnas
str(datos)#estructura, n casos, tipo variables...

#tipo de datos:
class(datos$eval)
#puedo refedinirlo
datos$eval <- as.factor(datos$eval)
#reviso
class(datos$eval)

#otra informacion
range(datos$Titot)#rango de valores, min-max
mean(datos$Titot)#media aritmetica
median(datos$Titot)#mediana
#explorar como se comporta la variable
hist(datos$Titot)#grafico histograma

#instalar paquetes
#tidyverse
#cargar paquetes
require(tidyverse)

graf <- ggplot(datos,aes(Titot))+
  geom_histogram(col="darkmagenta",binwidth=15, 
                 fill="darkviolet", 
                 alpha = .2)+
  theme_minimal()
print(graf)
