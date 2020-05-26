#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

setwd("~/Desktop/飲食店喫茶店")

###################################
#基データ読み込み
data <- read.csv("住所緯度経度.csv", fileEncoding="CP932")

#同一緯度経度で、店舗数を計算
dataA <- aggregate(x=data$緯度, by=list(data$緯度, data$経度), FUN=length)

#カラム名変更
dataA <- dataA %>% rename(緯度=Group.1, 経度=Group.2, 店舗数=x)

#書き出し
write.csv(dataA, "飲食店喫茶店緯度経度別集計.csv", fileEncoding="CP932", row.names=FALSE)

###################################################
#　24区地図描画
#地図ファイル読込
shape <- st_read("h27_did_27.shp") #eStatから大阪府を取得

#フォント
par(family="HiraKakuProN-W3")

#区境 xlimとylimをshapeと合わせないとずれる
plot(st_geometry(shape[1:24,4]), xlim=c(135.4,135.6), ylim=c(34.59,34.77), col="white", main="食品営業許可施設（飲食店、喫茶店）　令和元年12月27日現在")

#店舗をプロット(円の大きさは店舗数)
points(dataA$経度, dataA$緯度, pch=16, col="red", cex=0.3)
