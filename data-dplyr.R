#dplyr
dim(head(diamonds,n=4))
library(magrittr)
diamonds %>% head(4) %>% dim

install.packages("dplyr")
library(dplyr)

#select
diamonds[,c("carat","price")]
select(diamonds,carat,price)
diamonds %>% select(carat,price)
diamonds %>% select(c(carat,price))

theCols <- c('carat','price')
diamonds %>% select_(.dots=theCols) #used less

diamonds %>% select(starts_with('c')) #coulmn name is c start
diamonds %>% select(ends_with('e')) #coulmn name is e end
diamonds %>% select(contains('a')) #coulmn name is contains a
diamonds %>% select(matches('r.+t')) #coulmn name Regular Expression
diamonds %>% select(-carat,-price) # use "-" no carat, price coulmn

#filter
diamonds[diamonds$cut=="Ideal",]
diamonds %>% filter(cut=="Ideal")
diamonds %>% filter(cut %in% c('Ideal','Good')) # %in%
diamonds %>% filter(price>=1000)
diamonds %>% filter(price != 1000)
diamonds %>% filter(carat>2,price<14000)
diamonds %>% filter(carat<1 | carat>5)
theCol <- 'cut'
theCut <- 'Ideal'
diamonds %>% filter_(sprintf("%s=='%s'",theCol,theCut)) # column:cut,value=Ideal

#slice
diamonds %>% slice(1:5)
diamonds %>% slice(c(1:5,8,15:20)) #total 12 rows
diamonds %>% slice(-10) #move 10 rows

#mutate
diamonds %>% mutate(price/carat) 
diamonds %>% select(carat,price) %>% mutate(Ratio=price/carat)
diamonds %>% select(carat,price) %>% mutate(Ratio=price/carat,Double=Ratio*2)

#summarize
diamonds %>% summarise(mean(price))
diamonds %>% summarise(AvgPrice=mean(price),MedianPrice=median(price),AvgCarat=mean(carat))

#group_by
diamonds %>% group_by(cut) %>% summarise(AvgPrice=mean(price))
diamonds %>% group_by(cut) %>% summarise(AvgPrice=mean(price),SumCarat=sum(carat))
diamonds %>% group_by(cut,color) %>% summarise(AvgPrice=mean(price),SumCarat=sum(carat))

#arrange:sort
diamonds %>% group_by(cut) %>% summarise(AvgPrice=mean(price),SumCarat=sum(carat)) %>% arrange(AvgPrice)
diamonds %>% group_by(cut) %>% summarise(AvgPrice=mean(price),SumCarat=sum(carat)) %>% arrange(desc(AvgPrice))

#do
topN <- function(x,N=5) {
  x %>% arrange(desc(price)) %>% head(N)
}
diamonds %>% group_by(cut) %>% do(topN(.,N=3)) # "."
diamonds %>% group_by(cut) %>% do(Top=topN(.,N=3)) # like ldply
