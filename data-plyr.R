install.packages("plyr")
library(plyr)

head(baseball)
baseball$sf[baseball$year<1954] <- 0 #sf 1954 is 0
any(is.na(baseball$sf)) #baseball$sf is no NA
baseball <- baseball[baseball$ab>=50,]
baseball$OBP <- with(baseball,(h+bb+hbp)/(ab+bb+hbp+sf))
baseball

#ddply
obp <- function(data) {
  c(OBP=with(data,sum(h+bb+hbp)/sum(ab+bb+hbp+sf)))
}
careerOBP <- ddply(baseball,.variables = "id",.fun = obp)
careerOBP <- careerOBP[order(careerOBP$OBP,decreasing = TRUE),]
head(careerOBP,10)

#llply
theList <- list(A=matrix(1:9,3),B=1:5,C=matrix(1:4,2),D=2)
lapply(theList,sum)
llply(theList,sum)
identical(lapply(theList,sum),llply(theList,sum)) #lapply = llply

#lapply
sapply(theList,sum)
lapply(theList,sum)

#each
library(ggplot2)
aggregate(price~cut,diamonds,each(mean,median)) #diamonds in library(ggplot2)

#idata.frame
system.time(dlply(baseball,"id",nrow))
iBaseBall <- idata.frame(baseball) #data big
system.time(dlply(iBaseBall,"id",nrow))
