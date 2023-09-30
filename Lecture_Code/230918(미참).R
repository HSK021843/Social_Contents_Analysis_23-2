library(gganimate)
library(ggplot2)
library(gifski)

dept <- c("영업 1팀", "영업 2팀", "영업 3팀")
sales <- c(12, 5, 8)
df1 <- data.frame(부서 = dept, 매출 = sales, 분기 = "1분기")

dept <- c("영업 1팀", "영업 2팀", "영업 3팀")
sales <- c(10, 8, 5)
df2 <- data.frame(부서 = dept, 매출 = sales, 분기 = "2분기")

df <- rbind(df1, df2)
df

anim <- ggplot(df, aes(x = 부서, y = 매출, fill = 분기)) +
  geom_bar(stat = "identity") +
  labs(title = "부서별 분기별 영업실적") +
  transition_states(분기)

animate(anim, width = 400, height = 300,
        duration = 6,
        renderer = gifski_renderer(loop = TRUE))
