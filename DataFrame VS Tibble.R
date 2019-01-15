# data frame VS tibble

# data frame Base R。tibble 是 R 語言中獨有的資料架構，改善了 data.frame 的一些缺點，與 data.frame 有類似的語法，但使用起來更方便。

#install.packages("tidyverse")
library(tibble) 

###############################################################################

# 建立 data frame
x <- c(1:20)
y <- 1
z <- x^2+y
df.data <- data.frame(x,y,z) #data.frame(x = c(1:5),y = 1,z = x^2+y)無法直接創建data frame
df.data # 顯示所有資料。只顯示column name
head(df.data,10) # 顯示前10筆資料。
df.data[,1,drop=FALSE] # 選取子集合時會回傳向量。除非設定drop=FALSE。
str(df.data[,1]) # int [1:20] 1 2 3 4 5 6 7 8 9 10 ...
str(df.data[,1,drop=FALSE]) #'data.frame':	20 obs. of  1 variable: $ x: int  1 2 3 4 5 6 7 8 9 10 ...

# 建立 tibble
tib.data <- tibble(
  x = c(1:20),
  y = 1,
  z = x^2+y
  )
tib.data # 顯示10筆資料。顯示column name and column type
tib.data[,1] # tibble 仍會回傳 tibble 物件
str(tib.data[,1]) #Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	20 obs. of  1 variable:$ x: int  1 2 3 4 5 6 7 8 9 10 ...

## 轉換資料型態 ##
Dr.Lee <- list(gender="man", age=18, hobby=c("tease", "be teased"))
class(Dr.Lee)

# 轉換資料型態為data frame
df.Lee <- as.data.frame(Dr.Lee,stringsAsFactors = FALSE)
class(df.Lee)
df.Lee

# 轉換資料型態為tibble
tib.Lee <- as_tibble(Dr.Lee,stringsAsFactors = FALSE)
class(tib.Lee) 
## [1] "tbl_df"     "tbl"        "data.frame" 
## tbl_df 繼承了 tbl 類型，tbl 繼承了data.frame，簡單來說，tibble 其實是 data.frame 的子類型。
## 如果不熟悉的話，你只要看 class 的第一個結果有沒有 tbl 即可
tib.Lee 

###############################################################################
## column ##

# 查 column 個數
ncol(df.Lee)

ncol(tib.Lee)

# 查 column name
names(df.Lee)
names(df.Lee)[3]
colnames(df.Lee)
colnames(df.Lee)[3]

names(tib.Lee)
names(tib.Lee)[3]
colnames(tib.Lee)
colnames(tib.Lee)[3]

# 改 column name
names(df.Lee) <- c("DFgender","DFCage","DFChobby")

names(tib.Lee) <- c("TibCgender","TibCage","TibChobby")

# 新增 column
## 1.cbind，效能差
name1 <- c("John","Jack")
addc.df1 <- cbind(DFgender=df.Lee[,1],name1,df.Lee[,2:ncol(df.Lee)]) #指定 column 位置 ## 注意:只有1個 column 要給 column name
addc.df1

addc.tib1 <- add_column(tib.Lee,name1=c("John","Jack"),.before = 2) #指定 column 位置
addc.tib1

## 2.直接加 column name
addc.df1$name2 <- c("John2", "Jack2")
addc.df1[["name2"]] <- c("John2", "Jack2")
addc.df1[,"name2"]  <- c("John2", "Jack2")
addc.df1

addc.tib1$name2 <- c("John2", "Jack2")
addc.tib1[["name2"]] <- c("John2", "Jack2")
addc.tib1[,"name2"]  <- c("John2", "Jack2")
addc.tib1

# 移除 column
names(addc.df1) # [1] "DFgender" "name1"    "DFCage"   "DFChobby" "name2" 
addc.df1$name2 <- NULL
names(addc.df1) # [1] "DFgender" "name1"    "DFCage"   "DFChobby"
addc.df1 <- addc.df1[,-2] # [1] "DFgender" "DFCage"   "DFChobby"
names(addc.df1)

names(addc.tib1) # [1] "TibCgender" "name1"      "TibCage"    "TibChobby"  "name2" 
addc.tib1$name2 <- NULL
names(addc.tib1) # [1] "TibCgender" "name1"      "TibCage"    "TibChobby"
addc.tib1 <- addc.tib1[,-2] # [1] "DFgender" "DFCage"   "DFChobby"
names(addc.tib1) # "TibCgender" "TibCage"    "TibChobby" 

# column 資料型態
str(df.Lee[]) 

str(tib.Lee[])

# 改變 column 資料型態
str(df.Lee[,1]) # $ gender: chr  "man" "man"
#df.Lee[,1] <- as.factor(df.Lee[,1]) ##注意:不可使用df.Lee[1] <- as.factor(df.Lee[1]) $ gender: Factor w/ 1 level "man": NA NA
df.Lee$DFgender <- as.factor(df.Lee$DFgender)
str(df.Lee[,1])

str(tib.Lee[,1]) # $ gender: chr  "man" "man"
#注意:不可使用 tib.Lee[,1] <- as.factor(tib.Lee[,1])、tib.Lee[1] <- as.factor(tib.Lee[1])
tib.Lee$TibCgender <- as.factor(tib.Lee$TibCgender) 
str(tib.Lee[,1]) # $ gender: Factor w/ 1 level "man": 1 1

###############################################################################
## row ##
# 查 row 個數
nrow(df.Lee)

nrow(tib.Lee)

# 新增 row

## 1.rbind，效能差
## 注意: factor 的元素值只能是 levels 中的其中一種或是缺失值（NA）
##       如果將 factor 的元素指定為其他的字串，該元素就會被設定為缺失值。
nlevels(df.Lee$DFgender) # factor 數量 ## [1] 1
levels(df.Lee$DFgender) # factor 的 level ## [1] "man"
str(df.Lee$DFgende) # Factor w/ 1 level "man": 1 1
levels(df.Lee$DFgender) <- c(levels(df.Lee$DFgender), "woman")
str(df.Lee$DFgender) # Factor w/ 2 levels "man","woman": 1 1
addr.df1 <- rbind(df.Lee[1,],c("woman",19,"tease"),df.Lee[2:nrow(df.Lee),]) #指定 row 位置
str(addr.df1$DFgender) #  Factor w/ 2 levels "man","woman": 1 2 1
addr.df1

## 注意: factor 的元素值只能是 levels 中的其中一種或是缺失值（NA）
##       如果將 factor 的元素指定為其他的字串，該元素就會被設定為缺失值。
nlevels(tib.Lee$TibCgender) # factor 數量 ## [1] 1
levels(tib.Lee$TibCgender) # factor 的 level ## [1] "man"
str(tib.Lee$TibCgender) # Factor w/ 1 level "man": 1 1
levels(tib.Lee$TibCgender) <- c(levels(tib.Lee$TibCgender), "woman")
str(tib.Lee$TibCgender) # Factor w/ 2 levels "man","woman": 1 1
addr.tib1 <- add_row(tib.Lee,TibCgender="woman",TibCage=19,TibChobby="tease",.before=2) #指定 row 位置
str(addr.tib1$TibCgender) # Factor w/ 2 levels "man","woman": 1 2 1
addr.tib1

# 移除 row
addr.df1 # 1 , 2 , 21
addr.df1 <- addr.df1[-21, ]
addr.df1 # 1 , 21
addr.df1 <- addr.df1[-c(2,21), ]
addr.df1 # 1 

addr.tib1 # 1 , 2 , 3
addr.tib1 <- addr.tib1[-2, ]
addr.tib1 # 1 , 2
addr.tib1 <- addr.tib1[c(-2), ]
addr.tib1 # 1 

###############################################################################
## total ##
# 查  row，column 總比數
dim(df.Lee) # [1] 2 3

dim(tib.Lee) # [1] 2 3

# 查 資料結構
str(df.Lee)

str(tib.Lee)

# 查 second row，third column 資料
df.Lee[2,3]

tib.Lee[2,3]

# 查 be teased 資料
subset(df.Lee, DFChobby == "be teased")

subset(tib.Lee, TibChobby == "be teased")
