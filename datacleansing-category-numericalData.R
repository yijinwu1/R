# install.packages("readx1")
library(readxl) #user excel_sheets(), read_excel()

#download.file(url='https://github.com/yijinwu1/R/tree/master/excel/RamenShop.xlsx',destfile='C:/Users/wuyijin/Desktop/RamenShop.xlsx')

excel_sheets('C:/Users/wuyijin/Desktop/RamenShop.xlsx') #sheet name
remean <- read_excel('C:/Users/wuyijin/Desktop/RamenShop.xlsx',sheet = "拉麵店",col_names = TRUE)
View(remean) 

oldprice <- remean$price

sum(is.na(oldprice)) #Is there a NA value?
sum(is.null(oldprice)) #Is there a NULL value?
sort(unique(oldprice),na.last = TRUE,decreasing = FALSE) # kind

summary(oldprice) #Min,1st Qu,Mean,3rd Qu,Max
(minprice <- min(oldprice,na.rm = TRUE))
(maxprice <- max(oldprice,na.rm = TRUE))
(meanprice <- mean(oldprice,na.rm = TRUE))
(sdprice <- sd(oldprice,na.rm = TRUE))
('M-3' <- meanprice - 3*sdprice) # mean - 3*sd 
('M+3' <- meanprice + 3*sdprice) # mean + 3*sd

# NumericalData use Stem-and-Leaf Graph
stem(oldprice)

# NumericalData use boxplot  Outlier(boxplot,Grubbs)
boxplot(oldprice,horizontal = TRUE,col = "bisque") #Boxplot

# NumericalData use Grubbs
# install.packages("outliers")
library(outliers) #use grubbs.test()
grubbs.test(oldprice) # Grubbs H0:No outliers、H1:outliers, G > p-value => H0-yes,H1-no

# breaks use Sturges (Suggest)
(group <- (1+log10(100)/log10(2))) #Sturges
(grouprange <- (maxprice-minprice) / group) #Group distance
(breakseq <- as.vector(seq(minprice,maxprice,length.out = group)))#cut breaks. a numeric vector

#cut(x, breaks, labels = NULL,include.lowest = FALSE, right = TRUE, dig.lab = 3,ordered_result = FALSE, ...)
# labels:By default, labels are constructed using "(a,b]" interval notation. 
# If labels = FALSE, simple integer codes are returned instead of a factor
# group by Struges
labels <- c("A","B","C","D","E","F","G")
remeanshop1 <- cut(oldprice,breaks = c(breakseq),include.lowest = TRUE,right = FALSE,labels = labels) 
table(remeanshop1)

# Group by yourself (500~600、600~700、700~800、800~900、900~1000)
selfbreak <- c(500,600,700,800,900,1000)
remeanshop <- cut(oldprice,breaks = selfbreak,include.lowest = TRUE,right = FALSE) 
table(remeanshop)

# NumericalData use Histogram
hist(oldprice,breaks = selfbreak,include.lowest = TRUE,right = FALSE) # Frequency
rug(oldprice,col="red") #Adds a rug representation (1-d plot) of the data to the plot

par(mfrow=c(2,1))
# NumericalData use dotchart
dotchart(oldprice)
# NumericalData use box
boxplot(oldprice,horizontal = TRUE,col = "red")

par(mfrow=c(1,1))
# NumericalData use 常態機率圖
qqnorm(oldprice); qqline(oldprice,col='red')

#density
hist(oldprice,breaks = selfbreak,include.lowest = TRUE,right = FALSE,probability = TRUE) # Densitis
rug(oldprice) #Adds a rug representation (1-d plot) of the data to the plot
lines(density(oldprice),col='red') #density

# install.packages("dplyr")
library(dplyr)
remeanshop2 <- as.data.frame(cbind(shop=remean$shop,price=remean$price,remeanshop)) #add clo group
remeanshop2 <- mutate(remeanshop2, newprice=price/10) # add col
View(remeanshop2)

count(remeanshop2,vars=remeanshop2$remeanshop) # vars:variables to count unique values of
aggregate(price ~ remeanshop,remeanshop2,sum) # aggregate
select(remeanshop2,c(remeanshop,price)) # select
filter(remeanshop2,remeanshop==1) # filter

View(as.data.frame(t(remeanshop2[,3:2]))) # transpose
