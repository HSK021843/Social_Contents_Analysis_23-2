library(ggplot2)
library(showtext)
showtext.auto()

company <- c("크라운", "롯데", "오리온", "해태")
revenue <- c(10, 20, 40, 10)
df <- data.frame(기업 = company, 매출 = revenue)
df

ggplot(data = df, aes(x = "", y = 매출, fill = 기업)) +
  geom_bar(stat = "identity", color = "black") + 
  coord_polar(theta = "y") +
  geom_text(aes(label = 매출),
            color = "black",
            position = position_stack(vjust = 0.5)) +
  theme_void() +
  scale_fill_manual(values = c("red", "lightgreen", "gold", "skyblue"))
