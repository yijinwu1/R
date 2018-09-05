#.xls,.xlsx
#excel file must be download file,destfile path must be correct
download.file(url='http://www.jaredlander.com/data/ExcelExample.xlsx',destfile='../ExcelExample.xlsx',mode='wb')

#Hadley Wickham package readxl
install.packages("readxl")
library(readxl)

#sheets name
excel_sheets('../ExcelExample.xlsx') 

#sheer is number or sheet name
totmatoXL <- read_excel('../ExcelExample.xlsx',sheet = 'Wine')
totmatoXL
