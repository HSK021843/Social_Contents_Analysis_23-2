library(ggplot2)

data(mtcars)

ggplot(data = mtcars, aes(y = hp)) +
  geom_boxplot(col = "black", fill = "lightblue") +
  labs(title = "hp�� ����", x = "", y = "hp")
