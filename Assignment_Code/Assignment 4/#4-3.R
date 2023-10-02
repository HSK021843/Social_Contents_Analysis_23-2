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

ggplot(df, aes(x = ���, y = ����, fill = ����)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") + 
  labs(title = "����� ������ ����")