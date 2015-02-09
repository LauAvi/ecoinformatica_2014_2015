##SCRIPT QUE SUMA LOS NÚMERO PARES
##los simbolos %% calculan el resto de una division if(k%%2==0). LA DIVISIÓN DE LOS NUMEROS PARES ENTRE DOS, DE RESTO DA CERO.
suma<-0
for(k in 1:10){ #BUCLE "PARA" CUALQUIER VALOR DE K COMPRENDIDO EN LA SECUENCIA DEL 1 AL 10
if(k%%2==0){  #PARA CALCULAR EL RESTO DE LA DIVISIÓN
suma<-suma+k
}}
print(suma)
