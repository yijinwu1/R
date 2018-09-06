install.packages("ggplot2")
library(ggplot2)

head(diamonds)

#aggregate:calculate slower
aggregate(price~cut,diamonds,mean,na.rm=TRUE) # ~ (formula) left is calculate, right is group
aggregate(price~color+cut,diamonds,mean) # + (plus) right tow group
aggregate(cbind(price,carat)~cut,diamonds,mean)
