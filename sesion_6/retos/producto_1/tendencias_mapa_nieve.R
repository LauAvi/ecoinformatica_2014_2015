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

nieve<-read.csv("./nieve_robledal.csv", header= TRUE, sep=";", dec=".")
str(nieve)
head(nieve)
View(nieve)
#CREO DOS TABLAS PARA PODER GUARDAR LOS VALORES OBTENIDOS DEL BUCLE

datos <- data.frame()  #EN ESTA TABLA VACIA SE VAN A ALMACENAR LOS DATOS GENERADOS EN EL BUCLE
valor <- data.frame(nie_malla_modi_id=NA, #ESTA TABLA ME VA PERMITIR CAPTAR CADA UNA DE LAS VUELTAS QUE GENERE MI BUCLE
                    tau=NA,           #EVITANDO ASI QUE SE SOBREESCRIBAN Y PODER ALMACENAR LOS VALORES EN LA DATOS
                    pvalue=NA)

#CREO EL ELEMENTO PIXELS, TOMA DE MI TABLA EL VALOR DEL PIXEL UNICAMENTE (nie_malla_modi_id)
pixels<- unique(nieve$nie_malla_modi_id)


#BUCLE LO REALIZO PARA OBTENER UN VALOR DEL NUMERO DE DIAS QUE EL PIXEL ESTA CUBIERTO POR NIEVE 

for (k in pixels){ #para valores de dias que el pixel esta cubiero por nieve.
  #subset de datos
  aux <- nieve[nieve$nie_malla_modi_id==k,]
  m <- MannKendall(aux$scd) #relizo el análisis de Mannkendall, que me va a dar tau y p_valor (subset de kendall)
  valor$nie_malla_modi_id <- k # ID_del pixels (nie_malla_modi_id)
  valor$tau <-m$tau[1] #tau
  valor$pvalue <- m$sl[1] #p_value
  datos <- rbind(datos, valor)
}

nieve1<- nieve[,c(2,10:11)] #creo una tabla igual a la nieve, con el mismo número de filas pero solo con las columnas que quiero
coord_pixel <- unique(nieve1) #creo una tabla de coordenadas, pero que me tome un único valor de las coordenadas, a partir de la tabla anterior.


tendencia <-join(x=datos, y=coord_pixel, by='nie_malla_modi_id')
str(tendencia)
head(tendencia)

##CREAR SHAPE, nieve.
library(shapefiles)
## definimos las coordenadas de los puntos
coordinates(tendencia) =~lng+lat
## definimos el sistema de coordenadas WGS84
proj4string(tendencia)=CRS("+init=epsg:4326")
writeOGR(tendencia, dsn=getwd(), layer="NIEVE", driver="ESRI Shapefile")

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

plot(tendencia, col=colcode, pch=19, cex = .6, main = "Mapa de tendencias Nieve")
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
