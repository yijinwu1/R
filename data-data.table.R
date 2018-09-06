#data.frame (character -> factor) vs data.table 
library(data.table)
theDF <- data.frame(A=1:10,B=letters[1:10],C=LETTERS[11:20],D=rep(c("One","Two","Three"),length.out=10))
theDT <- data.table(A=1:10,B=letters[1:10],C=LETTERS[11:20],D=rep(c("One","Two","Three"),length.out=10))
class(theDF$B)
class(theDT$B)

theDT[1:2,]
theDT[theDT$A>=7,]
theDT[A>=7,]
theDT[,list(A,C)]
theDT[,c("A","C"),with=FALSE]
theDT[,B]
theDT[,"B",with=FALSE] #column name set with=FALSE
theDT[,list(B)]

diamondsDT <- data.table(diamonds)
diamondsDT

setkey(theDT,D) #set index
theDT["One",]
theDT[c("One","Two"),]

setkey(diamondsDT,cut,color) #J() only for use inside DT[...].
diamondsDT[J("Ideal","E"),] 
diamondsDT[J("Ideal",c("E","D")),]

aggregate(price~cut,diamonds,mean)
diamondsDT[,list(price=mean(price)),by=cut]

aggregate(price~color+cut,diamonds,mean)
diamondsDT[,list(price=mean(price)),by=list(cut,color)]

aggregate(cbind(price,carat)~cut,diamonds,mean)
diamondsDT[,list(price=mean(price),carat=mean(carat)),by=cut]

diamondsDT[,list(price=mean(price),carat=mean(carat),caratSum=sum(carat)),by=cut] #more calculate

aggregate(cbind(price,carat) ~ cut+color,diamonds,mean)
diamondsDT[,list(price=mean(price),carat=mean(carat)),by=list(cut,color)]
