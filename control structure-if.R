#if(---) {----} else if(---) {----}
score <- 67
if(score >= 90) {
  print(paste("A:",as.character(score)))
} else if (score >= 80) {
  print(paste("B:",as.character(score)))	
} else if (score >= 70) {
  print(paste("C:",as.character(score)))	
} else if (score >= 60) {
  print(paste("D:",as.character(score)))	
} else {
  print(paste("E:",as.character(score)))	
}

#ifelse(test,yes,no)
ifelse(1==0,"Yes","No") 

toTest <- c(1,1,0,1,0,1,NA)
ifelse(toTest==1,"yes","no") #NA is NA
