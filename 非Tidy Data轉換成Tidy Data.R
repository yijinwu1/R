# Tidy Data三個條件(normal principle)
#  1.每個變數(variale)都會形成一個column
#  2.每個觀察個體(observation)都會形成一個row
#  3.每一種類型的觀察個體會形成一個table,比如說:地區特徵跟個體資料應該存成兩個不同的資料表格
# install.packages("tidyverse")
library(readr) 
library(tidyr)

pew <- read_delim("http://stat405.had.co.nz/data/pew.txt",delim="\t")
pew #data 信仰與所得。所得被拆分為好幾個級距，每個級距自成一個 column 。不符合tidy data 原則。          

#Column 其實是值而不是變數 - 使用 Gather
# gather(data, #待處理的資料
#        key = "key", #新變數的欄位名稱
#        value = "value", #新變數變數值的儲存欄位名稱
#        ..., #要被蒐集起來變成新變數的 columns
#        na.rm = FALSE, #是否刪除遺失值資料
#        convert = FALSE, #轉換特殊格式
#        factor_key = FALSE)

pew.colnames <- colnames(pew) # [1] religion、<$10k、$10-20k、$20-30k、$30-40k、$40-50k、$50-75k、$75-100k、$100-150k、>150k、Don't know/refused
pew.new <- pew %>% 
  gather(key="income",value="cases",pew.colnames[2:ncol(pew)]) # 將<$10k、$10-20k、$20-30k、$30-40k、$40-50k、$50-75k、$75-100k、$100-150k、>150k、Don't know/refused，column 收集起來
colnames(pew.new) # [1] religion、income、cases，轉換成信仰、所得、人數
pew.new

################################################################################################

table2 #country、year、type、count，type cloumn 存在cases與population兩個值，不符合tidy data 原則。 

#把變數當成值 - 使用 spread
# spread(data, #待處理的資料
#        key, #要被拆開成 variables 的 column
#        value, #變數值從哪裡來
#        fill = NA,
#        convert = FALSE,
#        drop = TRUE,
#        sep = NULL #如果是NULL，回直接將 key 的值當成新 columns 的名稱，如果輸入其他分隔符號，會回傳：“paste0(key_name,sep,key_value)”。
#        )

table2 %>%
  spread(key=type,value=count,sep='_') # country、year、type_cases、type_population，轉換成國家、年度、type_cases個數、type_population個數

################################################################################################

tb <- read_csv("https://raw.githubusercontent.com/yijinwu1/R/master/excel/tb.csv")
tb #資料把值存在 column：m_0-4 代表男性 0 - 4 歲的個體數。兩個變數存在同一個值：m_0-4 存了兩個變數。不符合tidy data 原則。

## 1.處理把值存在 column。使用gather()
tb.colnames <- colnames(tb) # iso2、year、new_sp、m_0-4、m_5-14、m_0-14、m_15-24、m_25-34、m_35-44、m_45-54、m_55-64、m_65、m_unknown、f_0-4、f_5-14、f_0-14、f_15-24、f_25-34、f_35-44、f_45-54、f_55-64、f_65、f_unknown
tb.new <- tb %>%
  gather(key = "type",value="cases",tb.colnames[4:ncol(tb)])
tb.new # iso2、year、new_sp、type、cases，轉換成iso2、year、new_sp、type、數目

#多個變數儲存在同一個 column 中 - 使用 separate
# separate(data,
#          col, #需要被分開column的名稱
#          into, #分隔成新columns的名稱
#          sep = "[^[:alnum:]]+", #用來分隔欄位的分隔符號，以正規表達式 (regular expression) 表示。
#          remove = TRUE,
#          convert = FALSE, #data type 轉換
#          extra = "warn",
#          fill = "warn",
#          ...)

## 2.處理兩個變數存在同一個值。使用separate()
tb.new %>%
  separate(col=type,into=c("gender","age"),sep="_",convert=TRUE) #轉換成iso2、year、new_sp、gender、age、cases

################################################################################################

tb <- read_csv("https://raw.githubusercontent.com/yijinwu1/R/master/excel/tb_new.csv")
tb #age_lb、age_ub被存成兩個column，不符合tidy data 原則。

#一個變數被分存在不同 columns 中 - 使用 unite 函數
# unite(data,
#       col, #合併完成後的新 column 名稱 
#       ..., #用來合併的原有 columns 名稱
#       sep = "_", #用來分隔欄位的分隔符號，以正規表達式 (regular expression) 表示
#       remove = TRUE)

tb %>%
  unite(col="age",c("age_lb","age_ub"),sep="-") # 將age_lb、age_ub合併成一個column
## # A tibble: 103,844 x 6
##    iso2   year new_sp gender age   cases
##    <chr> <dbl>  <dbl> <chr>  <chr> <dbl>
## 1  AD     1989     NA m      0-4      NA
