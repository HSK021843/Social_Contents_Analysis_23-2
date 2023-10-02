library(ggplot2)
library(showtext)
showtext.auto()

company <- c("SKT", "KT", "LGT")
rev_2021 <- c(13, 35, 42)
rev_2022 <- c(16, 38, 39)
df1 <- data.frame(��� = company, ���� = rev_2021, ���� = "2021��")
df2 <- data.frame(��� = company, ���� = rev_2022, ���� = "2022��")
df <- rbind(df1, df2)
df

ggplot(data =df, aes(x = ����, y = ����, group = ���, color = ���)) +
  geom_line(size = 1.5) +
  geom_point(color = "red", size = 2) +
  labs(title = "����� ������ ����")