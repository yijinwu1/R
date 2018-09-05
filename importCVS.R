#csv 
#read_csv2,read_tsv

theUrl <- "http://www.jaredlander.com/data/Tomato%20First.csv"

csv_df <- read.csv(theUrl,skip=1,header = FALSE,col.names = c('Round','Tomato', 'Price',' Source','Sweet','Acid','Color','Texture','Overall','Avg of Totals','Total of Avg'))
head(csv_df)

tomato <- read.table (file = theUrl, header = TRUE, sep = ",")  # read slower
head(tomato)

install.packages("readr")
library(readr)
tomato2 <- read_delim(file=theUrl, delim=',') # big data,no set stringsAsFactors,return tibble
tomato2
class(tomato2)

install.packages("data.table")
library(data.table)
tomato3 <- fread(input=theUrl, sep=',', header=TRUE) # big data,fast,return data.table,stringsAsFactors:FALSE
tomato3
class(tomato3)
