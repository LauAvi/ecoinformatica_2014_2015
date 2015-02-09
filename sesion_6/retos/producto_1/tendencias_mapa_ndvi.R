#ME DICE CUAL ES MI DIRECTORIO DE TRABAJO
getwd()


#ESTABLEZCO MI DIRECTORIO DE TRABAJO.
setwd("/home/lj03/ecoinformatica_2014_2015/sesion_6/retos/producto_1")

##CARGO LAS LIBRERIAS QUE ME HAGAN FALTA
library(Kendall)
install.packages(c('plyr'), dep=T) ##PLYR ME VA A PERMITIR COMBINAR TABLAS FRENTE A LOS PATRONES QUE YO DECIDA (COMANDO JOIN)
library(plyr)
library(raster)

#COMIENZO EL ANÁLISIS DE TENDENCIAS DEL NDVI.
#LEO LA TABLA DE NDVI_ROBLEDAL.csv

ndvi<-read.csv("./ndvi_robledal.csv", header= TRUE, sep=";", dec=".")
str(ndvi)
head(ndvi)
View(ndvi)
#CREO DOS TABLAS PARA PODER GUARDAR LOS VALORES OBTENIDOS DEL BUCLE

datos <- data.frame()  #EN ESTA TABLA VACIA SE VAN A ALMACENAR LOS DATOS GENERADOS EN EL BUCLE
valor <- data.frame(iv_malla_modi_id=NA, #ESTA TABLA ME VA PERMITIR CAPTAR CADA UNA DE LAS VUELTAS QUE GENERE MI BUCLE
                    tau=NA,           #EVITANDO ASI QUE SE SOBREESCRIBAN Y PODER ALMACENAR LOS VALORES EN LA DATOS
                    pvalue=NA)

#CREO EL ELEMENTO PIXELS, TOMA DE MI TABLA EL VALOR DEL PIXEL UNICAMENTE (iv_malla_modi_id)
pixels<- unique(ndvi$iv_malla_modi_id)


#BUCLE LO REALIZO PARA OBTENER UN VALOR DE NDVI POR CADA PIXEL Y AÑO

for (k in pixels){ #para valores de ndvi por año para cada pixel
  #subset de datos
  aux <- ndvi[ndvi$iv_malla_modi_id==k,]
  m <- MannKendall(aux$ndvi_i) #relizo el análisis de Mannkendall, que me va a dar tau y p_valor (subset de kendall)
  valor$iv_malla_modi_id <- k # ID_del pixels (iv_malla_modi_id)
  valor$tau <-m$tau[1] #tau
  valor$pvalue <- m$sl[1] #p_value
  datos <- rbind(datos, valor)
}

ndvi1<- ndvi[,c(1,4:5)] #creo una tabla igual a la ndvi, con el mismo número de filas pero solo con las columnas que quiero
coord_pixel <- unique(ndvi1) #creo una tabla de coordenadas, pero que me tome un único valor de las coordenadas

tendencia <-join(x=datos, y=coord_pixel, by='iv_malla_modi_id')
str(tendencia)
head(tendencia)

##CREAR LA SHAPE NDVI. 
install.packages(c('shapefiles'), dep=T)
library(shapefiles)
install.packages(c('maptools'), dep=T)
library (maptools)
writeORG<-(tendencia)
## definimos las coordenadas de los puntos
coordinates(tendencia) =~lng+lat
## definimos el sistema de coordenadas WGS84
proj4string(tendencia)=CRS("+init=epsg:4326")
writeOGR(tendencia, dsn=getwd(), layer="NDVI", driver="ESRI Shapefile")


readORG<-(tendencia)
View(tendencia)
plot(tendencia)
write.table(tendencia, file="tendencia.dbf", row.names=FALSE, sep=';')

readShapePoly(snevada, proj4string = CRS(as.character(NA)), verbose = FALSE,
                repair=FALSE)

#PINTAR EL MAPA
library(sp)
library(rgdal)
install.packages(c('classInt'), dep=T)
library(classInt)
library(RColorBrewer)

## definimos las coordenadas de los puntos
coordinates(tendencia) =~lng+lat
## definimos el sistema de coordenadas WGS84
proj4string(tendencia)=CRS("+init=epsg:4326")

## partimos los valores de tau en 5 clases
clases <- classIntervals(tendencia$tau, n = 5)
## obtenemos cinco colores para una paleta de colores que se llama
"Spectral"
plotclr <- rev(brewer.pal(5, "Spectral"))
## Asociamos los valores de tau a su valor correspondiente
colcode <- findColours(clases, plotclr)

plot(tendencia, col=colcode, pch=19, cex = .6, main = "Mapa de tendencias")
## mostramos la leyenda
legend("topright", legend=names(attr(colcode, "table")),
       fill=attr(colcode, "palette"), bty="n")

###### Otra forma de pintar el mapa

tendendia$significativa <- ifelse(tendencia$pvalue < 0.05, 1, 2)
## plot sin tener en cuenta
plot(tendencia, col=colcode, pch=c(19, 20)[as.numeric(tendencia$significativa)],
     cex = .6, main = "Mapa de tendencias")
## mostramos la leyenda
legend("topright", legend=names(attr(colcode, "table")),
       fill=attr(colcode, "palette"), bty="n")