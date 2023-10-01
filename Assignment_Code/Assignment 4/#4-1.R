library(ggplot2)
theme_set(theme_grey(base_family = 'NanumGothic'))

company <- c("크라운", "롯데", "오리온", "해태")
revenue <- c(10, 20, 40, 10)
df <- data.frame(기업 = company, 매출 = revenue)
df

ggplot(data = df, aes(x = 기업, y = 매출, fill = 기업)) +
  geom_bar(stat = "identity", color = "black") + 
  labs(title = "기업별 영업 실적", x = "기업명", y = "매출(억원)")
