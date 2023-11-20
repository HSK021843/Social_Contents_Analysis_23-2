library(dplyr)
library(GGally)

# 10.2 데이터 프로파일링
# 원래 빈 칸 & 문제가 발생해서 생긴 빈 칸(일반적으로 NA/원래는 숫자인 경우는 NaN -> NA, NaN 모두 결측치) -> 빈 칸만 있음
# NULL: 초기화 -> 빈 칸도 없음
# Inf, n/0 등: 무한대
# [숫자]: 숫자 번째
# 0/0: NaN
W <- c("가", "나", "", "라", "마", "바", "사", "아", "아", "차")
X <- c(1, 2, 3, NA, 5, 6, 7, 8, 9, 0)
Y <- c(10, 20, NULL, 40, 50, NaN, 70, 80, 90, 100, 110)
Z <- c(5, 10/0, Inf, -20/0, -Inf, 0/0, NaN, 40, 45, 50)
df <- data.frame(W, X, Y, Z) 
str(df)
summary(df)
nzchar(df$W)

empty <- apply(df, 2, nzchar) # df에 2의 방향(세로 방향)으로 nzchar 적용(1은 가로 방향)
empty

colSums(!empty) # 세로줄별 빈칸 합
rowSums(!empty) # 가로줄별 빈칸 합

# df 전체의 Na를 찾아서 합하기
is.na(df)
sum(is.na(df))

# NA 찾기
colSums(is.na(df))
rowSums(is.na(df))

is.infinite(df$Z) # is.infinite(df)는 불가 -> 벡터만 가능 // colSum, rowSum 불가능
sum(is.infinite(df$Z))


# GGally
iris
str(iris)
summary(iris)

library(GGally)
library(dplyr)

ggpairs(data = iris, # pair plot(2개씩 짝을 만듬) 만들기
        columns = 1:4, # 1~4번 칼럼 추출
        upper = list(continuous = wrap("cor", size = 6)))
        # upper: 상관분석의 수치 6칸 + 분포도(대각선을 기준으로 대칭으로 그림)
        # upper 대신 다른 옵션을 적용하면 그래프 위치가 달라짐짐
        # 대각선: 각 요소의 분포

ggpairs(data = iris,
        columns = 1:4,
        upper = list(continuous = wrap("smooth", alpha = 0.3)))
        # smooth 옵션을 사용한 옵션

ggpairs(data = iris,
        columns = 1:4,
        aes(color = Species, alpha = 0.5),
        upper = list(continuous = wrap("cor", size = 2.5)))
        # 꽃 종류별로 나눠서 표시



# 10.3 데이터 정제
W <- c("가", "나", "", "라", "마", "바", "사", "아", "아", "차")
X <- c(1, 2, 3, NA, 5, 6, 7, 8, 9, 0)
Y <- c(10, 20, NULL, 40, 50, NaN, 70, 80, 90, 100, 110)
Z <- c(5, 10/0, Inf, -20/0, -Inf, 0/0, NaN, 40, 45, 50)
df <- data.frame(W, X, Y, Z) 
df

# NA가 있는 열을 제거
df2 <- na.omit
df2

# dplyr의 filter 함수 이용 -> 조건을 걸고, 만족하는 경우
df2 <- filter(df, is.finite(Z)) # Z열의 유한한 수가 있는 경우만 가져옴옴
df2

# 모든 조건을 만족한 경우만 출력 + 출력할 열은 선택 X
df2 <- filter(df, nzchar(W) & is.finite(X) &
                is.finite(Y) & is.finite(Z))
df2

# subset을 이용해서 다양한 조건을 지정 + select 함수로 결과로 출력할 열을 선택
df2 <- subset(df, nzchar(W) & is.finite(X) &
                is.finite(Y) & is.finite(Z),
              select = c(W, X))
df2

# 다양한 전처리 -> 지정된 데이터에 특정 수치 넣기
# []: index(R의 index는 1부터 시작)
# $: 특정 데이터프레임의 특정 열을 지정(df$colName)
df3 <- df
df3$X[df3$X == 0] <- 10
df3$X[is.na(df3$X)] <- 4
df3$Y[is.nan(df3$Y)] <- 60
df3$Z[is.nan(df3$Z)] <- 30
df3$Z[df3$Z >= Inf ] <- 10
df3$Z[df3$Z <= -Inf] <- 20
df3$W[df3$W == ""] <- "Unknown"
df3 

df3 <- df
df3$X[df3$X == 0] <- 10
df3$X[is.na(df3$X)] <- mean(df3$X[is.finite(df3$X)])
df3$Y[is.nan(df3$Y)] <- median(df3$Y[is.finite(df3$Y)])
df3$Z[is.nan(df3$Z)] <- mean(df3$Z[is.finite(df3$Z)])
df3$Z[df3$Z >= Inf ] <- max(df3$Z[is.finite(df3$Z)])
df3$Z[df3$Z <= -Inf] <- min(df3$Z[is.finite(df3$Z)])
df3$W[df3$W == ""] <- "다"
df3 


# 10.4 데이터 통합
library("dplyr")
df1 <- data.frame(ID=1:3, 성명=c('장발장', '팡틴', '자베르'))
df1

df2 <- data.frame(ID=2:4, 경력=c(7, 5, 10))
df2

inner_join(df1, df2, by = "ID")

left_join(df1,df2, by = "ID")

right_join(df1,df2, by = "ID")

full_join(df1,df2, by = "ID") 