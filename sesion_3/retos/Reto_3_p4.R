##instalo paquete Raster.
# install.packages(c('raster'), dep=T)
library(raster)
# install.packages(c('sp'), dep=T)

# Establezco el directorio
setwd("/home/lj03/ecoinformatica_2014_2015/sesion_3/retos")

hora <- c(12,13,14,15)

valores_ndvi <- c()

for (k in hora){
# leer todas las imagenes de una hora
imagen_horas <- list.files(path="./ndvi", full.names=TRUE, recursive=TRUE, 
                      pattern=paste("_", k ,"..\\.jpg\\.asc$", sep=""))

# Creamos in stack 
stack_imagenes <-stack(imagen_horas)

# media por pixel 
media_pixel <- mean(stack_imagenes)

# media por hora de todos los pixeles
# media_hora <- mean(media_pixel[])

# valores_ndvi <- rbind(valores_ndvi, media_hora)
valores_ndvi <- rbind(valores_ndvi, mean(media_pixel[]))
}

plot(c(12,13,14,15),valores_ndvi, xlab='Horas', ylab='media NDVI', pch=19, col='red', main='dddd')



