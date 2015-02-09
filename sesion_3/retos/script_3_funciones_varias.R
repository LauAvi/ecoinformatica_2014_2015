##Este script me dice lo que hace varias funciones.

##Crear matrices: El 2 es el número de filas y el 5 son las columnas
x<-matrix(seq(1:10),2,5)
x #me devuelve una matriz de las caracteristicas que le he dicho (2 filas y 5 columnas) 
#[,1] [,2] [,3] [,4] [,5]
#[1,]    1    3    5    7    9
#[2,]    2    4    6    8   10
x[1,3]? 
x[2, ]? #SUPUESTAMENTE ME DEVOLVERIA UN NÚMERO DE LA MATRIZ, PERO NO PASA NADA...¿PREGUNTAR?
x[, 3]?


mode(x)  ## muestra el tipo de objeto
#[1] "numeric"  (resultados de la consola)

str(x)   ## obtenemos la estructura de un objeto
# int [1:2, 1:5] 1 2 3 4 5 6 7 8 9 10  (resultados de la consola)

length(x) ## devuelve la longitud de un vector
# [1] 10 (resultados de la consola)

mean(x)  ## devuelve el valor medio
# [1] 5.5 (resultados de la consola)

max(x)  ## devuelve el máximo
# [1] 10 (resultados de la consola)
##Raster, list.files, paste, stack, mean, rbind, plot
##Te hace una lista de los documentos dentro del diterctorio.
list.files ()

##Une todos los vectores de caracteres que se le suministran y construye una sola
#cadena de caracteres. Cada argumento se separa del siguiente con un espacio en blanco
# se puede cambiar pos "sep" que sustituye el espacio en blanco.
paste()

#Concatenar varios vectores en un vector único. Debe de tener alguno de estos argumentos, 
#x siendo una lista o data.frame que se quiera concatenar, select que indica las variables 
#que se seleccionan de la data.frame o from  
stack()

#Construyen matrices uniendo unas con otras verticalmente (por fila). Sustituye
#filas por columnas
rbind()

