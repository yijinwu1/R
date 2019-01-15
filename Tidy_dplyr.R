# dplyr是 R 語言中最常被用來進行資料轉換的套件，內建許多與 SQL 相似的函數，幫助我們在 R 中完成資料轉換。
# dplyr 套件有幾個好處：
## 提供以「動詞」為命名的函數，讓你能夠直接將想達成的資料轉換翻譯成程式碼
## 提供資料轉換的「標準化框架」，有系統的思考你需要做的資料轉換
## 在效能上# 有優化，較其他套件的函數快上不少

# install.packages("tidyverse")
library(dplyr) 
library(ggplot2)

mtcars.tb <- as_tibble(mtcars)
View(mtcars.tb) # 1973 - 1974 年 32 款汽車的相關變數 11 種。

diamonds.tb <- as_tibble(diamonds)
View(diamonds.tb)

# filter():Row 的篩選
mtcars.tb %>%
  filter(mpg > 20, hp > 100) # 篩選出一加侖汽油的可以跑超過 20 km 且馬力超過 100 匹馬力的汽車

diamonds.tb %>%
  filter(cut == "Ideal") # 篩選出 cut column 值 "Ideal"(值有大小寫之分)
## 使用變數標記。注意:filter_()，字串標記符號。
Col <- 'cut'
Val <- 'Ideal'
diamonds.tb %>%
  filter_(sprintf("%s == '%s'",Col,Val))

diamonds.tb %>%
  filter(cut %in% c("Ideal","Good")) # 篩選出 cut column 值 "Ideal" 與 "Good"(值有大小寫之分)

diamonds.tb %>%
  filter(carat < 0.3 | carat > 5) # 篩選出 carat column 值介於 0.3 ~ 5 之間

# slice():抓指定比數資料
mtcars.tb %>%
  slice(1:4) # 抓取前4筆資料

mtcars.tb %>%
  slice(-4) # 移除前4筆資料

mtcars.tb %>%
  slice(-4) # 移除前4筆資料

mtcars.tb %>%
  slice(c(1:3,9)) # 抓前3筆資料與第9筆資料

# select():Column 的篩選
mtcars.tb %>%
  select(mpg, hp, gear) # 選出「一加侖汽油可跑距離」、「馬力」、與「前進檔數」三個 column

mtcars.tb %>%
  select(-mpg) # 排除 mpg column

mtcars.tb %>%
  select(starts_with('d')) # column name d 開頭

diamonds.tb %>%
  select(ends_with('t'))  # column name t 結尾

diamonds.tb %>%
  select(contains('a')) # column name 包含 a

mtcars.tb %>%
  filter(mpg > 20, hp >100) %>% # 篩選出一加侖汽油的可以跑超過 20 km 且馬力超過 100 匹馬力汽車的「前進檔數」
  select(gear)
  
# arrange():資料排序。asc(default)、desc
# 注意:sort()、order()、rank()，秩的函數。vector排序
mtcars.tb %>%
  arrange(cyl, disp) # 依 cyl、disp 排序

mtcars.tb %>%
  arrange(desc(disp)) # 依 disp 做降冪排序
 
# mutate():建立新的變數
mtcars.tb %>%
  mutate(cyl2 = cyl * 2, cyl4 = cyl2 * 2) # 多兩個 column:cyl2、cyl4
## mpg    cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb  cyl2  cyl4
## <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>

mtcars.tb %>%
  mutate(mpg = NULL, disp = disp * 0.0163871) # mgp column 消失， disp column 值為 disp * 0.0163871
##       cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
##      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1      6  2.62   110  3.9   2.62  16.5     0     1     4     4

# transmute():只保留建立 new column
mtcars.tb %>%
  transmute(displ_l = disp / 61.0237) # 產生 displ_l column
##      displ_l
##       <dbl>
## 1     2.62

# group_by():根據組別加總
mtcars.tb %>%
  group_by(cyl) # 產生汽缸數量分組

## brower():R的debug函數，brower()看group_by()的執行狀況。console 區執行
### Browse[1]> .
## mtcars.tb %>%
##  group_by(cyl) %>%
##  do(browser())

mtcars.tb %>%
  group_by(cyl) %>%
  filter(rank(desc(hp)) < 4) %>% 
  arrange(desc(cyl),desc(hp))    # 依 cy1 分組，篩選 hp 排名降冪前3名，依 cy1、hp 做降冪排列

# summarise():分組後的資料總結
mtcars.tb %>%
  group_by(cyl) %>%
  summarise(number=n(),avg_hp=mean(hp),sd_hp=sd(hp),max_hp=max(hp),min_hp=min(hp)) %>%
  arrange(desc(avg_hp))
## # A tibble: 3 x 6
##       cyl number avg_hp sd_hp max_hp min_hp
##     <dbl>  <int>  <dbl> <dbl>  <dbl>  <dbl>
## 1     8     14  209.   51.0    335    150
## 2     6      7  122.   24.3    175    105
## 3     4     11   82.6  20.9    113     52
