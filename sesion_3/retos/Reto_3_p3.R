##Algoritmo que dadas 10 temperaturas por el usuario, te de la media
suma <- 0
for (i in 1:10) {
  temperatura<-scan(n=1:10)
  suma <- suma + temperatura
  
}

media <- suma/10
media
