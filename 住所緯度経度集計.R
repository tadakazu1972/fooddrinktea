library(dplyr)

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


#描画
{
  #書き出しファイル設定
  quartz(type="pdf", file="クラス別平均_H28_5年4教科.pdf")

  #描画
  par(family="HiraKakuProN-W3")

  #線形回帰計算
  result <- lm(標準化得点4教科~児童数, dataC)

  #相関係数　タイトルに使うので先に計算
  r <- cor(dataC$児童数, dataC$標準化得点4教科)

  #学校
  plot(result$model$児童数, result$model$標準化得点4教科, pch=16, col=4, cex=1, xlab="クラス別　平成28年　5年　児童数", ylab="クラス別　平成28年 5年　4教科合計(標準化得点)", main=paste("クラス別　標準化得点と児童数の相関  (r=", round(r, digits=2), ")", sep=""))
  text(result$model$児童数, result$model$標準化得点4教科+0.4, labels=dataC$学校名, cex=0.4)

  #回帰直線
  abline(result, lwd=3)

  # 回帰直線の傾きと切片をそれぞれa,bに代入
  a <- result$coefficients[["児童数"]]
  b <- result$coefficients[["(Intercept)"]]
  plus <- ifelse(b>0, "+", "") #bが以上であれば"+"の記号を描画。マイナスであればNull

  #R2を取り出す
  name <- summary(result)
  r2 <- name$r.squared

  #回帰式とR2　描画
  legend("topright", legend=paste("y=", round(a, digits=4), "x ", plus, " ", round(b, digits=4), sep=""))
  legend("bottomleft", legend=paste("R^2 =", round(r2, digits=4), sep=""))

  dev.off()
}
