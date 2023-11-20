# 8.3 미세먼지 농도의 시간대별 그래프 비교 
library(XML)
library(ggplot2)

api <- "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst"
api_key <- "JWAqnzOqjIFuN8FJ0r2LdgnMUhqibm9AKLiVF07wrL9JOIz5ojFeMRGr80uDXMaC0LRUREVAxGaUnCrBOrYEZw%3D%3D"
numOfRows <- 10 #시간 설정
pageNo <- 1
itemCode <- "PM10"
dataGubun <- "HOUR"
searchCondition <- "MONTH"

# 링크 만들기
url <- paste(api,
             "?serviceKey=", api_key,
             "&numOfRows=", numOfRows,
             "&pageNo=", pageNo,
             "&itemCode=", itemCode,
             "&dataGubun=", dataGubun,
             "&searchCondition=", searchCondition,
             sep="")
url

# XML 파일로 저장 및 실행행
xmlFile <- xmlParse(url)
xmlFile

# getNodeSet을 이용해서 특정 태그가 있을 때 그 하위 정보를 가져옴
# 정보를 가져온 후 DataFrame화 -> 경기만 따로 떨어져 있음을 확인할 수 있음
df <- xmlToDataFrame(getNodeSet(xmlFile, "//items/item"))
df

ggplot(data=df, aes(x=dataTime, y=seoul)) +
  geom_bar(stat="identity", fill="orange") +
  theme(axis.text.x=element_text(angle=90)) +
  labs(title="시간대별 서울지역의 미세먼지 농도 변화", x = "측정일시", y = "농도") 



# 8.4 지역별 미세먼지 농도의 지도 분포
# 원하는 데이터를 원하는 지역의 정중앙에 표시하기기
library(ggplot2)
library(rgdal)
library(XML)

api <- "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst"
api_key <- "JWAqnzOqjIFuN8FJ0r2LdgnMUhqibm9AKLiVF07wrL9JOIz5ojFeMRGr80uDXMaC0LRUREVAxGaUnCrBOrYEZw%3D%3D"
numOfRows <- 10
pageNo <- 1
itemCode <- "PM10"
dataGubun <- "HOUR"
searchCondition <- "MONTH"

url <- paste(api,
             "?serviceKey=", api_key,
             "&numOfRows=", numOfRows,
             "&pageNo=", pageNo,
             "&itemCode=", itemCode,
             "&dataGubun=", dataGubun,
             "&searchCondition=", searchCondition,
             sep="")
url

xmlFile <- xmlParse(url)
xmlFile

df <- xmlToDataFrame(getNodeSet(xmlFile, "//items/item"))
df

# 원하는 가로/세로로 인덱스만 DataFrame화
pm <- df[1, c(1:16, 19)]
pm

# 데이터를 세로로 바꾸기
# pm.region의 class는 matrix(2차원 array) -> DataFrame으로 바꿔줘야함함
pm.region <- t(pm)
pm.region

# DataFrame으로 형식 변환
# column은 2개이나, 데이터는 1개 종류(variables = 1)
df.region <- as.data.frame(pm.region)
df.region

# colnames를 지정
colnames(df.region) <- "PM10"

# 여기서 variables가 2개가 됨
df.region$NAME <- c("대구광역시", "충청남도", "인천광역시", "대전광역시", "경상북도",
                    "세종특별자치시", "광주광역시", "전라북도", "강원도", "울산광역시",
                    "전라남도", "서울특별시", "부산광역시", "제주특별자치도", "충청북도",
                    "경상남도", "경기도")

df.region

# 지도 불러오기
shapefile_path <- "C:/Users/9902k/Documents/Z_NGII_N3A_G0010000.shp"
map <- readOGR(dsn = shapefile_path, encoding = "euc-kr")
crs <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs')
map <- spTransform(map, CRSobj = crs)

# 지도를 DataFrame화
df_map <- fortify(map)
head(df_map)

# 지도의 데이터를 info로 만듬 -> 필요한 데이터인 NAME이 포함됨
df_map_info <- map@data
df_map_info

# aggregate()를 이용해서 각 지역의 경/위도 평균을 계산 -> $id를 이용해서 같은 지역(같은 id)를 묶음
longlat <- aggregate(df_map[, 1:2], list(df_map$id), mean)
longlat
str(longlat)

# 문자열화된 id 컬럼을 숫자로 바꾸고(as.numeric), 정렬함(order)
colnames(longlat)[1] <- "id"
longlat$id <- as.numeric(longlat$id)
longlat <- longlat[order(longlat$id),]
longlat

# 지역명을 longlat에 붙여줌
longlat <- cbind(longlat, NAME=df_map_info[,3])
longlat

# df.region과 longlat을 합쳐서 PM10 DataFrame을 만듬 -> NAME을 기준으로 합침
df.PM10 <- merge(x = df.region, y = longlat, by = "NAME", all = TRUE)
df.PM10

ggplot() +
  geom_polygon(data = df_map,
               aes(x = long, y = lat, group = group),
               fill = "white", alpha=0.5,
               color="black") +
  geom_point(data=df.PM10,
             aes(x=long, y=lat, size=PM10),
             shape=21, color='black',
             fill='red', alpha=0.3) +
  theme(legend.position = "none") +
  labs(title="미세먼지 분포", x="경도", y="위도") 