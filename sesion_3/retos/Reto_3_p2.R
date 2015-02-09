##Algoritmo que dado un umbral por el usuario, dados 10 números por el usuario, cuente 
##cuántos de esos números supera el umbral indicado
numeros<-scan(n=10)
suma<- (suma=0)
# suma<- 0
umbral<-40
for (valor in numeros [1:10]){
  if (valor>umbral){
    suma<-suma+1}
}
print(suma)