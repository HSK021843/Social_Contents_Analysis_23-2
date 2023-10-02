library(ggplot2)
library(showtext)
showtext.auto()

company <- c("ũ���", "�Ե�", "������", "����")
revenue <- c(10, 20, 40, 10)
df <- data.frame(��� = company, ���� = revenue)
df

ggplot(data = df, aes(x = "", y = ����, fill = ���)) +
  geom_bar(stat = "identity", color = "black") + 
  coord_polar(theta = "y") +
  geom_text(aes(label = ����),
            color = "black",
            position = position_stack(vjust = 0.5)) +
  theme_void() +
  scale_fill_manual(values = c("red", "lightgreen", "gold", "skyblue"))