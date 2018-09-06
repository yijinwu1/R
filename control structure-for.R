#for
for(i in 1:5) {
  print(i) #answer is 1,2,3,4,5
}

#for next
for(i in 1:5){
  if(i==3) {
    next
  }
  print(i) #answer is 1,2,4,5
}

#for break
for(i in 1:5){
  if(i==3) {
    break
  }
  print(i) #answer is 1,2
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
