library(dplyr)

setwd("~/Desktop/飲食店喫茶店")

###################################
#基データ読み込み
data <- read.csv("飲食店喫茶店（コンビニ等除去）.csv", fileEncoding="CP932")

#営業所所在地、緯度、経度の列のみ残す
dataA <- data %>% select(営業所所在地, 緯度, 経度)

#ファイル書き出し
write.csv(dataA, "営業所所在地緯度経度.csv", fileEncoding="CP932", row.names=FALSE)
