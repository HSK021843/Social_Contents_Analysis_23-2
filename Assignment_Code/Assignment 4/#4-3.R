library(ggplot2)
library(showtext)
showtext.auto()

company <- c("SKT", "KT", "LGT")
rev_2021 <- c(13, 35, 42)
rev_2022 <- c(16, 38, 39)
df1 <- data.frame(기업 = company, 매출 = rev_2021, 연도 = "2021년")
df2 <- data.frame(기업 = company, 매출 = rev_2022, 연도 = "2022년")
df <- rbind(df1, df2)
df

ggplot(df, aes(x = 기업, y = 매출, fill = 연도)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") + 
  labs(title = "기업별 연도별 매출")