#for
for(i in 1:10) {
  print(i)
}

#rep
fruit <- c("apple","banana","pomegranate")
fruitLength <- rep(NA,length(fruit))
fruitLength

#nchar
for(a in fruit) {
  fruitLength[a] <- nchar(a)
}
fruitLength

fruitLength2 <- nchar(fruit)
fruitLength2
