##ASOCIAR COMENTARIOS 
## leemos el csv de internet
temperaturas <- read.table("http://www.iecolab.es/ecoinfo/temperatura.csv", header = TRUE,
                           sep= ",")
temperaturas
names(temperaturas) ##ESTE COMANDO ME DEVUELVE EL NOMBRE DE LAS COLUMNAS DE MI DATAFRAME

## calculamos la temperatura máxima de las máximas registradas
temperatura_max <- max(temperaturas$tmax) #el simbolo $= accedo en mi dataframe a la columna que quiera, solo tengo que poner el nombre.
temperatura_max

## mostramos la temperatura máxima
print(temperatura_max)

## calculamos la temperatura mínima de las máximas
temperatura_min <- min(temperaturas$tmax)
temperatura_min

## mostramos la temperatura mínima
print(paste("La temperatura minima de las temperaturas máximas es:",temperatura_min)) #Lo escrito entre comillas, aparece tal cual en el resultado

## mostramos un gráfico con la distribución de la temperatura mínima                         
plot(temperaturas$tmin) ##el comando original era: plot(x$tmin), he cambiado x por "temperaturas", ya que el objeto x no existe.
