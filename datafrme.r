#data frame
x <- 10:1
y <- -4:5
q <- c("Hockey", "Football", "Baseball", "Curling", "Rugby","Lacrosse", "Basketball", "Tennis", "Cricket", "Soccer")
theDF <- data.frame(x,y,q)

#column name
theDF <- data.frame(First=x,Second=y,Sport=q)
View(theDF)

#column number
ncol(theDF)
#column name
names(theDF)
names(theDF)[3]

#row number
nrow(theDF)
rownames(theDF)
rownames(theDF) <- c("One", "Two", "Three", "Four", "Five", "Six","Seven", "Eight", "Nine", "Ten")
View(theDF)
rownames(theDF) <-NULL
View(theDF)

#the numbers of rows and columns respectively
dim(theDF)
#Return the First Part
head(theDF)
head(theDF,n=7)
#Return the Last Part
tail(theDF)
tail(theDF,n=3)

theDF$Sport
theDF[,3]
theDF[,"Sport"]
theDF[["Sport"]]
theDF["Sport"]
theDF[,"Sport",drop=FALSE]

class(theDF[,"Sport"])
class(theDF[["Sport"]])
class(theDF["Sport"])
class(theDF[,"Sport",drop=FALSE])

theDF[3,2]
theDF[c(3,5),2]

theDF[,2:3]
theDF[,c("Second","Sport")]
      
theDF[3,2:3]
theDF[c(3,5),2:3]
theDF[2,]
theDF[2:4,]
