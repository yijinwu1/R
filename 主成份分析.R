######################################################
## 主成份分析(Principal Component Analysis)         ##
## 主成份分析(PCA)找出有效表達資料的新變數          ##
## 1.prcomp():主成份分析的基本函式                  ##
## 2.選擇多少個主成份                               ##
##   利用解釋變異量決定要保留多少主成分             ##
##   2.1 主成份變異數條狀圖                         ##
##   2.2 累積解釋圖                                 ##
## 3.主成份負荷(主成份和原變數的關係)               ##
##   相關係數絕對值　	相關程度                      ##
##    約=1	        完全相關(Perfect correlated)    ##
##    0.7~0.99	    高度相關(Highly correlated)     ##
##    0.4~0.69	    中度相關(Moderately correlated) ##
##    0.1~0.39	    低度相關(Modestly correlated)   ##
##    0.01~0.09	    接近無相關(Weakly correlated)   ##
##    約=0	        無相關                          ##
## 4.非負主成份分析                                 ##
## 5.總結                                           ##
######################################################

library("tidyverse")

ramen.data <- read_csv("C:\\Users\\wuyijin\\Desktop\\data\\ramen.csv")
ramen.data

summary(ramen.data)
str(ramen.data)

#相關矩陣
cor(ramen.data[,2:ncol(ramen.data)])

library(reshape2)
# melt():將寬資料轉成長資料
melt(cor(ramen.data[,2:ncol(ramen.data)]))

# 繪製相關係數熱圖(Heatmap)
ggplot(melt(cor(ramen.data[, 2:ncol(ramen.data)])),
       aes(Var1, Var2)) +
  geom_tile(aes(fill = value), colour = "white") +
  scale_fill_gradient2(low = "firebrick4", high = "steelblue",
                       mid = "white", midpoint = 0) +
  guides(fill=guide_legend(title="Correlation")) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        axis.title = element_blank())

#prcomp(x,scale.=FALSE):主成分分析(principal component)。scale.=TRUE:變數標準化

pca.model <- prcomp(ramen.data[,2:ncol(ramen.data)], scale. = TRUE)
names(pca.model)
# sdev:每個PCA可解釋變異數。 # rotation:變數的係數矩陣。
# center:標準化後變數的中心。# scale:標準化後變數的尺度。
# x:主成分分數。
summary(pca.model)
pca.model$sdev #標準差
pca.model$rotation #固有向量
pca.model$center
pca.model$scale
pca.model$x #每家店在各成分的得分

## 視覺化 start ################################
#熱圖係數矩陣
ggplot(melt(pca.model$rotation[, 1:3]), aes(Var2, Var1)) +
  geom_tile(aes(fill = value), colour = "white") +
  scale_fill_gradient2(low = "firebrick4", high = "steelblue",
                       mid = "white", midpoint = 0) +
  guides(fill=guide_legend(title="Coefficient")) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        axis.title = element_blank())

#點狀圖
par(mfrow=c(2,2)) #主成分一起看
dotchart(pca.model$rotation[,1],
         main="Loading Plot for PC1",
         xlab="Variable Loadings",
         col="red")

dotchart(pca.model$rotation[,2],
         main="Loading Plot for PC2",
         xlab="Variable Loadings",
         col="red")

dotchart(pca.model$rotation[,3],
         main="Loading Plot for PC3",
         xlab="Variable Loadings",
         col="red")

par(mfrow=c(1,1))
#陡坡圖
plot(pca.model,   # 放pca
     type="line", # 用直線連結每個點
     main="pca.model")
abline(h=1, col="blue")

#利用解釋變異量決定要保留多少主成分
var.exp <- tibble(
  pc = paste0("PC_", formatC(1:3, width=2, flag="0")),
  var = pca.model$sdev^2, #主成分解釋變異量=標準差平方
  prop = (pca.model$sdev)^2 / sum((pca.model$sdev)^2), #解釋變異比率=主成分解釋變異量/資料的總變異量
  cum_prop = cumsum((pca.model$sdev)^2 / sum((pca.model$sdev)^2)))

library(plotly)

#繪圖主成份變異數條狀圖
plot_ly(
  x = var.exp$pc,
  y = var.exp$var,
  type = "bar"
) %>%
  layout(
    title = "Variance Explained by Each Principal Component",
    xaxis = list(type = 'Principal Component', tickangle = -60),
    yaxis = list(title = 'Variance'),
    margin = list(r = 30, t = 50, b = 70, l = 50)
  )

#繪圖累計總變異量(資料總變異量超過80%)
plot_ly(
  x = var.exp$pc,
  y = var.exp$cum_prop,
  type = "bar"
) %>%
  layout(
    title = "Cumulative Proportion by Each Principal Component",
    xaxis = list(type = 'Principal Component', tickangle = -60),
    yaxis = list(title = 'Proportion'),
    margin = list(r = 30, t = 50, b = 70, l = 50)
  )
## 視覺化 end ################################
spca.score <- data.frame(pca.model$x)
row.names(spca.score) <- ramen.data$store

plot_ly(
  x = spca.score[, 1],
  y = ramen.data$Soup,
  text = ramen.data$store,
  type = "scatter",
  mode = "markers"
) %>% layout(
  title = "Soup v.s. PC 1 Score: Scatter Plot",
  xaxis = list(title = 'Principal Component 1'),
  yaxis = list(title = 'Return on Equity'),
  margin = list(r = 30, t = 50, b = 70, l = 50)
)

plot_ly(
  x = spca.score[, 1],
  y = spca.score[, 2],
  text = ramen.data$store,
  type = "scatter",
  mode = "markers"
) %>% layout(
  title = "PC 1 v.s. PC 2 Score: Scatter Plot",
  xaxis = list(title = 'Principal Component 1'),
  yaxis = list(title = 'Principal Component 2'),
  margin = list(r = 30, t = 50, b = 70, l = 50)
)
################################################

#非負主成份分析
#install.packages("nsprcomp")
library(nsprcomp)

nspca.model <- nscumcomp(ramen.data[,2:ncol(ramen.data)],k=90,nneg = TRUE,scale. = TRUE) # nneg=T 非負
names(nspca.model)
summary(nspca.model)

## 視覺化 start ################################
#熱圖係數矩陣
ggplot(melt(nspca.model$rotation[, 1:3]), aes(Var2, Var1)) +
  geom_tile(aes(fill = value), colour = "white") +
  scale_fill_gradient2(low = "firebrick4", high = "steelblue",
                       mid = "white", midpoint = 0) +
  guides(fill=guide_legend(title="Coefficient")) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        axis.title = element_blank())

#點狀圖
par(mfrow=c(2,2)) #主成分一起看
dotchart(nspca.model$rotation[,1],
         main="Loading Plot for PC1",
         xlab="Variable Loadings",
         col="red")

dotchart(nspca.model$rotation[,2],
         main="Loading Plot for PC2",
         xlab="Variable Loadings",
         col="red")

dotchart(nspca.model$rotation[,3],
         main="Loading Plot for PC3",
         xlab="Variable Loadings",
         col="red")

par(mfrow=c(1,1))
#陡坡圖
plot(nspca.model,   # 放pca
     type="line", # 用直線連結每個點
     main="nspca.model")
abline(h=1, col="blue")

#利用解釋變異量決定要保留多少主成分
var.exp <- tibble(
  pc = paste0("PC_", formatC(1:3, width=2, flag="0")),
  var = nspca.model$sdev^2, # 從pca中取出標準差(pca$sdev)後再平方，計算variance(特徵值)
  prop = (nspca.model$sdev)^2 / sum((nspca.model$sdev)^2), #計算每個主成分的解釋比例 = 各個主成份的特徵值/總特徵值
  cum_prop = cumsum((nspca.model$sdev)^2 / sum((nspca.model$sdev)^2))) #累加每個主成份的解釋比例

#繪圖主成份變異數條狀圖
plot_ly(
  x = var.exp$pc,
  y = var.exp$var,
  type = "bar"
) %>%
  layout(
    title = "Variance Explained by Each Principal Component",
    xaxis = list(type = 'Principal Component', tickangle = -60),
    yaxis = list(title = 'Variance'),
    margin = list(r = 30, t = 50, b = 70, l = 50)
  )

#繪圖累計總變異量(資料總變異量超過80%)
plot_ly(
  x = var.exp$pc,
  y = var.exp$cum_prop,
  type = "bar"
) %>%
  layout(
    title = "Cumulative Proportion by Each Principal Component",
    xaxis = list(type = 'Principal Component', tickangle = -60),
    yaxis = list(title = 'Proportion'),
    margin = list(r = 30, t = 50, b = 70, l = 50)
  )
## 視覺化 end ################################

##店家個別分析
nspca.score <- data.frame(nspca.model$x)
row.names(nspca.score) <- ramen.data$store

plot_ly(
  x = nspca.score[, 1],
  y = ramen.data$Soup,
  text = ramen.data$store,
  type = "scatter",
  mode = "markers"
) %>% layout(
  title = "Soup v.s. PC 1 Score: Scatter Plot",
  xaxis = list(title = 'Principal Component 1'),
  yaxis = list(title = 'Return on Equity'),
  margin = list(r = 30, t = 50, b = 70, l = 50)
)

plot_ly(
  x = nspca.score[, 1],
  y = nspca.score[, 2],
  text = ramen.data$store,
  type = "scatter",
  mode = "markers"
) %>% layout(
  title = "PC 2 v.s. PC 3 Score: Scatter Plot",
  xaxis = list(title = 'Principal Component 1'),
  yaxis = list(title = 'Principal Component 2'),
  margin = list(r = 30, t = 50, b = 70, l = 50)
)

#二元圖(個體、變數、主成分關係)
biplot(nspca.model)

#進行分層
#各欄位尺度不一致，針對數值欄位做極值正規化處理( (v-Min)/(Max-Min) )
ramen.cluster <- ramen.data[,2:4] %>%
  mutate(
    cluNoodles = (noodles - min(noodles)) / (max(noodles)-min(noodles)),
    cluMaterial = (material - min(material)) / (max(material)-min(material)),
    cluSoup = (Soup - min(Soup)) / (max(Soup)-min(Soup))
  )

ramen.cluster <- ramen.cluster[,4:6] #保留分群需要資料

#觀察資料的相關性
CorMatrix <- ramen.cluster %>% cor() %>% melt()
#繪製關聯熱力圖
ggplot( data = CorMatrix) +
  geom_tile(aes(Var1, Var2,fill = value), colour = "white") + 
  scale_fill_gradient2(low = "firebrick4", high = "steelblue") +
  guides(fill=guide_legend(title="Correlation")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        axis.title = element_blank())

set.seed(500) #隨機種子確保每次結果都一樣
#dist():計算距離
Distance <- dist(ramen.cluster, method = "euclidean") # euclidean:歐式距離
hclust(Distance,method="complete") %>% plot() #圖示約莫分2~3群左右

#Kmeans先分3群
set.seed(500) # remove the random effect
K <- kmeans(ramen.cluster,3)
ClusterResult <- cbind(ramen.cluster, K$cluster,row.names=ramen.data$store) %>% as.data.frame() # row.names:不依R預設值
colnames(ClusterResult)[ncol(ClusterResult)] <- 'Cluster' # K$cluster column name is Cluster
table(ClusterResult$Cluster)

# install.packages("ggfortify")
library(ggfortify)
set.seed(500)
autoplot(kmeans(ramen.cluster, 3), data  = ClusterResult, label=TRUE, label.size = 10)
