#解說 https://www.r-bloggers.com/examining-inter-rater-reliability-in-a-reality-baking-show/
df <- read.csv('https://github.com/mattansb/blogCode/raw/master/2018_10_18%20Inter-Rater%20Reliability/IJR.csv')
head(df)
dim(df)

library(dplyr) # for manipulating the data
install.packages("psych")
library(psych) # for computing Choen's Kappa
install.packages("corrr")
library(corrr) # for manipulating matrices

cohen.kappa(df)

df <- mutate(df,PASS = as.numeric(rowSums(df) >= 3))
head(df)

cohen.kappa(df)$cohen.kappa %>% as_cordf() %>% focus(PASS)
