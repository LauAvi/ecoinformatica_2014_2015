
#ME DICE CUAL ES MI DIRECTORIO DE TRABAJO
getwd()


#ESTABLEZCO MI DIRECTORIO DE TRABAJO.
setwd("/home/lj03/ecoinformatica_2014_2015/sesion_6/retos/producto_2")

library(raster)

#Leo la tabla con la información. 
robles<-read.csv("robles_ecoinfo.csv", header = T, sep = ",", dec=".")
str(robles)
head(robles)

#Creo una tabla igual que variables_roble, pero quitando las coordenadas
variables<- robles[,c(3,4:33)]#Definimos las variables que vamos a utilizar. Borramos las columnas "x" e "y" que no
#necesitamos "x" ni "y"

#Definimos el cluster de 3, voy a agrupar por 3 grupos.
n_cluster<-3

#Realizo un K-medias. Doy la orden de agrupar los pixels por 3 grupos, con un máximo de 200 interacciones. 

mi_cluster<-kmeans(variables, n_cluster, iter.max=200)

#Vuelvo a selecionar, las columnas de la UTM.
#El objetivo de este paso, es para combinar las UTM con el resultado del cluster.
coordenadas<-subset(robles,select=c(x,y))
head(coordenadas)

#Juntamos las coordenadas con el resultado de K-medias.
coordenadas<-cbind(coordenadas, mi_cluster[[1]])
head(coordenadas)
str(coordenadas)

#Nombramos la columna del cluster dentro de la tabla coordenadas.
colnames(coordenadas)[3]<-"mi_cluster"

library(sp)
library(rgdal)
library(classInt)
library(RColorBrewer)

## definimos las coordenadas de los puntos
coordinates(coordenadas) =~x+y
## definimos el sistema de coordenadas WGS84
proj4string(coordenadas)=CRS("+init=epsg:23030")

## obtenemos n_cluster colores para una paleta de colores que se llama "Spectral", para cada cluster creado
plotclr <- rev(brewer.pal(n_cluster, "Spectral"))

## plot, asignando el color en función del cluster al que pertenece
plot(coordenadas, col=plotclr[coordenadas$mi_cluster], pch=19, cex = .6, main = "Mapa de grupos de roble")

##creo una shape con el cluster.

library(shapefiles)
coordinates(coordenadas) =~x+y
## definimos el sistema de coordenadas WGS84
proj4string(coordenadas)=CRS("+init=epsg:23030")
writeOGR(coordenadas, dsn=getwd(), layer="cluster", driver="ESRI Shapefile")
