library(ggplot2)

data(mtcars)

ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(col = "black", fill = "skyblue", bins = 10) +
  labs(title = "mpg ºÐÆ÷", x = "mpg", y = "ºóµµ")
