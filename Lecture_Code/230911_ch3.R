# 3.2 벡터와 연산자
# 벡터 만들기 및 수정

score <- 70 # 1개 값을 score에 저장
score

score <- c(70, 80, 75) # 3개 값을 score에 덮어씌움
score

score[4] <- 100 # score 벡터의 4번째 자리에 100 저장
score[3] <- 95 # score 벡터의 3번째 자리에 95 저장
score

name <- c("장발장", "자베르", "팡틴") # name 벡터에 3개 문자열을을 저장
name

x <- seq(1, 10, by = 3) # x 벡터에 1부터 10까지 3씩 더한 값을 저장
x

x <- 10:1 # x 벡터에 10부터 1까지 1씩 뺀 값으로 덮어씌움
x

x <- 1:10 # x벡터에 1부터 10까지 1씩 더한 값으로 덮어씌움
x

x <- seq(0, 10, length.out = 5) # x 벡터에 0부터 10까지 동일한 간격으로 5개 값을 덮어씌움
x

x <- c(1, 2, 3) # x 벡터에 1, 2, 3 저장
y <- rep(x, times = 2) # x 벡터를 y 벡터에 2번 저장
y

y <- rep(x, each = 2) # x 벡터의 값을 순서대로 y 벡터에 2번씩 저장
y


# 연산자

10 + 3.5 # 10에 3.5 더하기
5^3 # 5를 3번 거듭제곱곱

x <- c(10, 20, 30, 40) # x 벡터에 값 저장
y <- c(10, 5, 12, 15) # y 벡터에 값 저장
w <- c(100, 200) # w 벡터에 값 저장

x + 5 # x 벡터의 각 값에 5 더하기
x + y # y 벡터의 각 값에 5 더하기
x + w # x 벡터의 각 값에 w의 값 더하기. 단, x 벡터가 끝날 때까지 y 벡터가 처음으로 되돌아가서 순서대로 더해짐

5 < 10 # 5보다 10이 큰가?

x <- c(10, 20, 30) # x 벡터에 값 저장
x <= 10 # x 벡터의 각 값이 10 이하인가? 단, TRUE/FALSE 값은 벡터 내부의 값 개수만큼 반환됨
any(x <= 10) # x벡터에 10 이하인 값이 존재하는가? 단, TRUE/FALSE 값은 1개
all(x <= 10) # x벡터의 모든 값이 10 이하인가? 단, TRUE/FALSE 값은 1개
x[x > 15] # x 벡터에서 15보다 큰 값은? 해당되는 모든 값 출력

x <- c(TRUE, TRUE, FALSE, FALSE) # x 벡터에 값 저장
y <- c(TRUE, FALSE, TRUE, FALSE) # y 벡터에 값 저장
x & y # AND 연산 결과
x | y # OR 연산 결과
xor (x, y) # XOR 연산 결과


# 결측치(NA / Not Available)와 NULL값

x <- NULL # x에 NULL값 지정
is.null(x) # x가 NULL값인지 확인

y <- c(1, 2, 3, NA, 5) # y 벡터에 값을 5개 저장하되, 하나가 NA값(결측치)임
y

z <- 10 / 0 # z에 10 / 0의 결과를 저장 -> Infinite 값이 저장됨(0이 아닌 수를 0으로 나눔)
z

u <- 0 / 0 # u에 0 / 0의 결과를 저장 -> NaN값이 저장됨(0을 0으로 나눔)
u



# 3.3 요인

gender <- c("남", "남", "여") # gender 벡터에 값 저장
gender

gender.factor <- factor(gender) # gender 벡터의 factor을 gender.factor에 저장
gender.factor



# 3.4 배열과 행렬
# 배열

x <- c(70, 85, 75) # x 벡터에 값 저장
arr <- array(x) # x 벡터를 배열로 바꾸고, arr에 저장(x 벡터가 모두 int이므로 가능함)
arr

z <- 1:6 # z 벡터에 값 저장
arr <- array(z, dim = c(2, 3)) # z 벡터를 2차원 배열로 바꿔서 arr에 저장(2 * 3 형태)
arr

name <- list(c("장발장", "자베르", "팡틴"),
             c("국어", "음악")) # name에 2개의 벡터로 이루어진 리스트 저장
score <- c(70, 80, 80, 75, 75, 90) # score에 6개 값 저장
arr <- array(score, dim = c(3, 2), dimnames = name) # 배열을 만들되, score을 세로 3줄, 가로 2줄로하고, name을 각 차원의 이름으로 지정)
arr

arr[3, 2] <- 95 # arr[3][2]의 값을 95로 바꿈
arr[3, 2]

arr[1,] # arr의 첫 번째 가로줄을 출력
arr[, 2] # arr의 두 번째 세로줄을 출력


# 행렬
x <- 1:6 # x에 1부터 6까지 저장
mtx <- matrix(x, nrow = 2) # row 개수를 2개로 해서 x를 matrix로 만듬듬
mtx

name <- list(c("1행", "2행"), c("1열", "2열", "3열")) # matrix의 이름 저장. 세로줄 2개, 가로줄 3개임
mtx <- matrix(x, nrow = 2, dimnames = name, byrow = TRUE) # mtx에 이름 붙이기기
mtx

y <- c(7, 8, 9) # y에 값 저장
mtx <- rbind(mtx, y) # rbind를 이용해 세로줄 추가
rownames(mtx)[3] <- "3행" # 세로줄 이름을 추가
mtx

z <- c(10, 11, 12) # z에 값 저장
mtx <- cbind(mtx, z) # cbind를 이용해 가로줄 추가
colnames(mtx)[4]<- "4열" # 가로줄 이름 추가
mtx



# 3.5 리스트

lst1 <- list(성명 = "장발장", 나이 = 40, 성적 = c(70, 80)) # lst1 생성. 항목명은 성명, 나이, 성적
lst1

lst1.gender <- list(성별 = "남") # 성별 항목 리스트 생성

lst1 <- append(lst1, lst1.gender, after = 1) # lst1에 성별 항목을 추가. after = 1을 통해 lst1.gender이 lst1 뒤에 추가됨을 알림
lst1
lst2 <- list(성명 = "팡틴", 성별 = "여", 나이 = 30, 성적 = c(75, 90)) # 새로운 리스트인 lst2 생성

lst <- list(lst1, lst2) # lst1과 lst2를 이용해 새로운 리스트인 lst 생성
lst

lst[1] # lst의 첫 번째 리스트 출력 -> 장발장 내용 출력
lst[[1]] # lst의 첫 번째 리스트를 출력하되, 리스트를 2번 unpack함?(장발장의 내용을 가져오고 난 후, 해당 내용 단독으로 인식한 채로 출력)
lst[[1]][1]
lst[[1]][[1]]
lst[[1]]$성명
lst