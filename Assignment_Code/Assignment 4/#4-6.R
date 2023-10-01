library(ggplot2)

data(mtcars)

ggplot(data = mtcars, aes(y = hp)) +
  geom_boxplot(col = "black", fill = "lightblue") +
  labs(title = "hp의 분포", x = "구간", y = "hp", width = 0.5)
