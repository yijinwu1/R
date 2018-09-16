install.packages("readx1")
library(readxl) #user excel_sheets(), read_excel()
#download.file(url='https://github.com/yijinwu1/R/tree/master/excel/RamenShop.xlsx',destfile='C:/Users/wuyijin/Desktop/RamenShop.xlsx')

excel_sheets('C:/Users/wuyijin/Desktop/RamenShop.xlsx') #sheet name. note file path.
uniform <- read_excel('C:/Users/wuyijin/Desktop/RamenShop.xlsx',sheet = "新制服",col_names = TRUE,range=cell_cols("A:B"))
View(uniform) 

orguniform <- uniform$`New uniform`

sum(is.na(orguniform)) #Is there a NA value?
sum(is.null(orguniform)) #Is there a NULL value?
sort(unique(orguniform),na.last = TRUE) # kind

Trows <- length(orguniform) # total rows
length(which(orguniform == "喜歡")) # total rows uniform$`New uniform` == "喜歡"

#Variable reprogramming
newuniform <- within(uniform,{
  preference <- NA #add col name "preference", default value set NA
  preference[orguniform == "喜歡"] <- 1
  preference[orguniform == "討厭"] <- 2
  preference[orguniform == "普通"] <- 3
})
View(newuniform)

colpreference <- newuniform$preference

sum(is.na(colpreference)) #Is there a NA value?
sum(is.null(colpreference)) #Is there a NULL value?
sort(unique(colpreference),na.last = TRUE) # kind

Trows <- length(colpreference) # total rows
NArows <- sum(is.na(colpreference)) # NA rows
NULLrows <- sum(is.null(colpreference)) # NULL rows
Valued <- table(colpreference) # every kind rows
NArows / Trows # NA Valued rate
NULLrows / Trows # NULL Valued rate
Valued / Trows # Valued rate

# Catgeory Data use Barplot Graph
par(mfrow=c(3,1)) # three picture displayed on the same page
barplot(colpreference) #no group
barplot(table(colpreference),col=c("red","blue","yellow")) # group
barplot(table(colpreference)/length(colpreference)) # rate

#Catgeory Data use Pie Graph
par(mfrow=c(1,1))
names(Valued) <- c("喜歡","討厭","普通")
pie(Valued,col = c("purple","green","cyan"),main="Pie Chart of Uniform")

pct <- round(Valued/Trows*100,3)
name <- c("喜歡","討厭","普通")
lbls <- paste(name,pct,"%")
pie(Valued,labels = lbls,main = "Pie Chart of Uniform")
