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


# 11.4 원주율 구하기
library(ggplot2)
library(ggforce)

iteration <- 100 # 점의 개수(사각형 안에 찍는 점의 개수) -> 반복 횟수와 동일
N.circle <- 0 # 원 안에 들어간 점의 개수
PI <- NULL # Pi 값 모아놓는 공간
pts <- NULL # 점 좌표쌍 데이터를 저장하는 공간

for(k in 1: iteration) { # 반복 범위
  x <- runif(1, min=0, max=1) # x에 대한 난수
  y <- runif(1, min=0, max=1) # y에 대한 난수
  
  pts <- rbind(pts, c(x, y)) # pts에 저장
  dist <- sqrt(x ^2 + y ^2) # 거리 계산
  if (dist <= 1) # 거리 조건에 맞추어서 값 증가
    N.circle <- N.circle + 1
  
  pi.sim <- 4 * N.circle # k # pi.sim 계산
  PI <- c(PI, pi.sim) # PI에 저장
}

PI.df <- data.frame("반복수"=1:iteration, "원주율"=PI) # 데이터프레임화
head(PI.df)
tail(PI.df)

ggplot(data=PI.df, aes(x=반복수, y=원주율, group=1)) +
  geom_line(color="blue", size=1) +
  geom_point() +
  geom_hline(yintercept=pi, color="red") +
  labs(title="시행횟수에 따른 원주율의 변화") # 원주율 그래프

pts.df <- as.data.frame(pts)
colnames(pts.df) <- c("X", "Y")
head(pts.df)

ggplot() +
  geom_point(data=pts.df, aes(x=X, y=Y)) +
  labs(title="시행횟수에 따른 점의 분포") +
  coord_cartesian(xlim = c(0, 1), ylim = c(0, 1)) +
  # geom_circle(aes(x0 = 0, y0 = 0, r = 1), col="red", inherit.aes = FALSE)
  geom_circle(aes(x0 = 0, y0 = 0, r = 1), col="red") # 원 안에 들어있는 점의 분포(원을 그리고, 점 찍기)