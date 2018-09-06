#apply only use in matix
theMatrix <- matrix(1:9,nrow = 3)
apply(theMatrix,1,sum) #sum row
rowSums(theMatrix)
apply(theMatrix,2,sum) #sum column
colSums(theMatrix)

theMatrix[2,1] <- NA
apply(theMatrix,1,sum) #NA
apply(theMatrix,1,sum,na.rm=TRUE) #No NA must add "na.rm=TRUE" 

#lapply in list or vector
theList <- list(A=matrix(1:9,3),B=1:5,C=matrix(1:4,2),D=2)
theList
lapply(theList,sum)
#answer is 
#         $`A`
#         [1] 45

#         $B
#         [1] 15

#         $C
#         [1] 10

#         $D
#         [1] 2

#sapply
sapply(theList,sum) 
#answer is  
#         A  B  C  D 
#         45 15 10  2

#mapply
firstList <- list(A=matrix(1:16,4),B=matrix(1:16,2),c=1:5)
firstList
secondList <- list(A=matrix(1:16,4),B=matrix(1:16,8),c=15:1)
secondList
mapply(identical,firstList,secondList)

simplyFunc <- function(x,y) {
  NROW(x)+NROW(y)
}
mapply(simplyFunc,firstList,secondList) #The Number of Rows
