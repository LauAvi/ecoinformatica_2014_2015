## Para introducir datos desde la ventana de comandos.
x<-scan(n=20)

##Para generar sucesiones numericas, genera un vector que empieza en 1 y acaba en 10, pero de dos en dos.
## generando una secuencia impar.
b<-seq(1, 10, 2)

##Genera aleatoriamente una distribución normal,
#de n=1000 y cuya media es igual a 3 y desviación estándar = 2.
normal<-rnorm(1000, mean = 3, sd = 2)

##Crea una matriz con distribución normal, nrow y ncol devuelven el número de filas y de columnas de una matriz.
f<-matrix(rnorm(1000), nrow = 10, ncol = 100)

##Ayuda con el paquete raster.
help(package = “raster”)