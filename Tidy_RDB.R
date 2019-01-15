# relational model 
#   variale/colmun => attribute
#  observation/row => tuple
#            table => relation
# install.packages("tidyverse")
library(tidyverse)

table.A <- tribble(
  ~key, ~val_A,
  1, "a_val_1",
  2, "a_val_2",
  3, "a_val_3",
  4, "a_val_4"
)

table.B <- tribble(
  ~key, ~val_B,
  1, "b_val_1",
  2, "b_val_2",
  5, "b_val_3"
)

# inner join():取兩個資料集合交集的個體進行合併
table.A %>% inner_join(table.B)
## Joining, by = "key"
## # A tibble: 2 x 3
##       key val_A   val_B  
##      <dbl> <chr>   <chr>  
## 1     1 a_val_1 b_val_1
## 2     2 a_val_2 b_val_2

# full join():取兩個資料集合的聯集進行合併
table.A %>% full_join(table.B)
## Joining, by = "key"
## # A tibble: 5 x 3
##      key val_A   val_B  
##     <dbl> <chr>   <chr>  
## 1     1 a_val_1 b_val_1
## 2     2 a_val_2 b_val_2
## 3     3 a_val_3 NA     
## 4     4 a_val_4 NA     
## 5     5 NA      b_val_3

# left join():將 A 集合中的所有個體與 B 集合的變數合併
table.A %>% left_join(table.B)
## Joining, by = "key"
## # A tibble: 4 x 3
##      key val_A   val_B  
##     <dbl> <chr>   <chr>  
## 1     1 a_val_1 b_val_1
## 2     2 a_val_2 b_val_2
## 3     3 a_val_3 NA     
## 4     4 a_val_4 NA 

# right_join():將 A 集合中的所有出現在 B 集合的個體其變數與 B 集合的變數合併
table.A %>% right_join(table.B)
## Joining, by = "key"
## # A tibble: 3 x 3
##       key val_A   val_B  
##     <dbl> <chr>   <chr>  
## 1     1 a_val_1 b_val_1
## 2     2 a_val_2 b_val_2
## 3     5 NA      b_val_3

# 一張資料表有重複鍵值
table.A <- tribble(
  ~key, ~val_A, ~foreign_key,
  "A1", "a_val_1", "B1",
  "A2", "a_val_2", "B1",
  "A3", "a_val_3", "B2",
  "A4", "a_val_4", "B2"
)

table.B <- tribble(
  ~key, ~val_B,
  "B1", "b_val_1",
  "B2", "bb_val_2"
)

table.A %>% 
  left_join(table.B, by = c("foreign_key" = "key"))
##   key   val_A   foreign_key val_B   
##  <chr>  <chr>   <chr>       <chr>   
## 1 A1    a_val_1 B1          b_val_1 
## 2 A2    a_val_2 B1          b_val_1
## 3 A3    a_val_3 B2          bb_val_2
## 4 A4    a_val_4 B2          bb_val_2

# 兩張資料表有重複鍵值
table.A <- tribble(
  ~key, ~val_A, ~foreign_key,
  "A1", "a_val_1", "B1",
  "A2", "a_val_2", "B1",
  "A3", "a_val_3", "B2",
  "A4", "a_val_4", "B2"
)

table.B <- tribble(
  ~key, ~val_B,
  "B1", "b_val_1",
  "B2", "bb_val_2.1",
  "B2", "bb_val_2.2"
)

table.A %>% 
  left_join(table.B, by = c("foreign_key" = "key"))
##   key   val_A   foreign_key val_B     
##  <chr> <chr>   <chr>       <chr>     
## 1 A1    a_val_1 B1          b_val_1   
## 2 A2    a_val_2 B1          b_val_1   
## 3 A3    a_val_3 B2          bb_val_2.1
## 4 A3    a_val_3 B2          bb_val_2.2
## 5 A4    a_val_4 B2          bb_val_2.1
## 6 A4    a_val_4 B2          bb_val_2.2


# watch.table：使用者的觀看內容與行為紀錄
watch.table <- read_csv("https://raw.githubusercontent.com/yijinwu1/R/master/excel/watch_table.csv")
watch.table # pk:watch_id, fk: user_id、drama_id

# user.table：使用者的個人資料
user.table <- read_csv("https://raw.githubusercontent.com/yijinwu1/R/master/excel/user_table.csv")
user.table # pk:user_id

# drame.table：戲劇的相關資料
drama.table <- read_csv("https://raw.githubusercontent.com/yijinwu1/R/master/excel/drama_table.csv")
drama.table # pk:drama_id

## 3個 Table 整合
full.table <- watch.table %>%
  left_join(user.table, by="user_id") %>%
  left_join(drama.table, by = "drama_id")
View(full.table) 

## 每部劇男性/女性的觀看次數
View(full.table %>% 
  group_by(drama_id, gender) %>%
  summarise(view_count = length(watch_id)))

## 每部劇男性/女性的觀看人數
View(full.table %>%
       group_by(drama_id,gender) %>%
       summarise(user_count = length(unique(user_id))))

#################################################################################

# semi_join():table.A 篩選出有出現在 table.B 的個體
View(user.table %>%
  semi_join(watch.table, by = "user_id"))
## 注意:如果同時要比對多個資料表的多個欄位時，用 filtering join 會比較好。
user.table %>%
  filter(user_id %in% watch.table$user_id)
## # A tibble: 13 x 6
##    user_id user_name    gender   age location  payment
##     <chr>   <chr>        <chr>  <dbl> <chr>       <dbl>
##  1 U0001   David Huang  male      24 Taipei          1
##  2 U0002   His Shen     male      25 Taipei          0
##  3 U0003   Julie Sung   female    37 Hsinchu         0
##  4 U0004   James Hsieh  male      29 Taipei          0
##  5 U0005   Jane Lin     female    18 Miaoli          1
##  6 U0006   Lobelia Wang female    42 Tainan          1
##  7 U0008   Lucas Yang   male      29 Taipei          0
##  8 U0009   Jason Chen   male      26 Taipei          0
##  9 U0010   Celine Lee   female    25 Yunlin          0
## 10 U0011   Jean Ding    female    28 Tainan          0
## 11 U0012   Eileen Liu   female    33 Kaohsiung       1
## 12 U0013   Joy Chiu     female    36 Taipei          1
## 13 U0015   Yiwen Yu     male      37 Hsinchu         0

# anti_join():table.A 篩選出沒出現在 table.B 的個體
user.table %>%
  anti_join(watch.table, by = "user_id")
## # A tibble: 2 x 6
##  user_id user_name  gender   age location  payment
##   <chr>   <chr>      <chr>  <dbl> <chr>       <dbl>
## 1 U0007   Cindy Kao  female    19 Kaohsiung       0
## 2 U0014   Ashley Kuo female    45 Taipei          1

## 集合運算
table.A <- tribble(
  ~var_1, ~var_2,
  "1-1","1-2",
  "2-1","2-2",
  "3-1","3-2-A"
)

table.B <- tribble(
  ~var_1, ~var_2,
  "1-1","1-2",
  "2-1","2-2",
  "3-1","3-2-B",
  "5-1","5-2"
)

# intersect(x,y):回傳同時出現在 x 與 y 的觀察個體
table.A %>% intersect(table.B)
## # A tibble: 2 x 2
##  var_1 var_2
##  <chr> <chr>
## 1 1-1   1-2  
## 2 2-1   2-2  

# union(x, y)：回傳有出現在 x 或 y 的觀察個體，且個體 / row 不會重複
table.A %>% union(table.B)
## # A tibble: 5 x 2
##  var_1 var_2
##  <chr> <chr>
## 1 2-1   2-2  
## 2 5-1   5-2  
## 3 3-1   3-2-A
## 4 3-1   3-2-B
## 5 1-1   1-2

# setdiff(x, y): 回傳有出現在 x 但沒有出現在 y 的觀察個體
table.B %>% setdiff(table.A)
## # A tibble: 2 x 2
##  var_1 var_2
##  <chr> <chr>
## 1 3-1   3-2-B
## 2 5-1   5-2 
