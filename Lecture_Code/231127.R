## 11.2 표본 추출과 난수
# 복원 추출
sample(1:10, 5, replace = T)
# 복원 추출
sample(c("앞면", "뒷면"), 5, replace=T)
# 비복원 추출
sample(1:10, 5, replace = F)
# 비복원 추출
sample(c("앞면", "뒷면"), 2, replace=F)
# 0과 1 사이의 수(실수)를 10번 출력
runif(10, min=0, max=1)


## 11.3 동전 던지기 
library(ggplot2)

iteration <- 1000 # 반복 횟수 지정
prob <- NULL # prob가 들어갈 칸 지정
count <- 0 # 작동 횟수

for(x in 1:iteration) { # 반복문 조건
  coin <- sample(c("앞면", "뒷면"), 1, replace=T) # 앞, 뒷면 출력
  
  if (coin == "앞면") # 앞면이면
    count = count + 1 # count에 1 추가
  
  prob <- c(prob, round(count / x, 2)) # prob에는 count / 반복 회차를 소수 셋째 자리에서 반올림해서 저장
}

df.coin<- data.frame("반복수"=1:iteration, "누적확률"=prob) # 전체 기록을 데이터프레임화
head(df.coin)
tail(df.coin)

ggplot(data=df.coin, aes(x=반복수, y=누적확률, group=1)) +
  geom_line(color="blue", size=1) +
  geom_point() +
  geom_hline(yintercept=0.5, color="red") +
  labs(title="동전 던진 횟수에 따른 누적확률의 변화") 