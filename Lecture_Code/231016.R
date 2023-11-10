#6-2
library(leaflet)

# 지도 그리기
# Pipe 함수를 덧셈 형식으로 사용
# 중심으로 둘 위경도 지정정 후, 확대 정도 지정
# addTiles()로 바탕화면 지정 -> 만역 없으면 지도가 출력이 되지 않음
m <- leaflet() %>% 
  setView(lng=126.976882, lat=37.574187, zoom = 1) %>% 
  addTiles()

# 마커 찍기기
m <- leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng=126.976882, lat=37.574187, 
             label="광화문광장", 
             popup="행사 안내")

m

m <- leaflet() %>% 
  setView(lng=126.976882, lat=37.574187, zoom = 14) %>% 
  addTiles() %>% 
  addMarkers(lng=126.986882, lat=37.574187, 
             label="광화문광장", 
             popup="행사 안내") 

m

#6-3
library(leaflet) 
library(ggplot2)

quakes 

# ~는 컬럼 값을 의미함
# radius부터는 원의 크기, 색상 등 설정
leaflet(data = quakes) %>% 
  addTiles() %>% 
  addCircleMarkers( 
    ~long, ~lat, 
    radius = ~ mag, # mag 대신 고정된 정수로 하면 항상 같은 크기의 원이 출력됨
    stroke = TRUE, weight = 1, color = "black", # 가장자리 설정(외곽선-?-색색)
    fillColor = "red", fillOpacity = 0.9) # 채우기 속성 지정(색-투명도도)

# 크기 설정을 위한 히스토그램
ggplot(quakes, aes(x=mag)) + 
  geom_histogram()

# 규모에 따른 원의 크기 재조정
leaflet(data = quakes) %>% 
  addTiles() %>% 
  addCircleMarkers( 
    ~long, ~lat, 
    radius = ~ifelse(mag >= 6, 10, 1), # ifelse를 이용해 원의 크기 정하기
                                      # -> 6 이상이면 10의 크기, 그렇지 않으면 1의 크기 -> 즉 원의 크기가 2개이다.
    stroke = TRUE, weight = 1, color = "black", 
    fillColor = "red", fillOpacity = 0.9)

# 규모에 따른 원의 크기 재조정
leaflet(data = quakes) %>% 
  addTiles() %>% 
  addCircleMarkers( 
    ~long, ~lat, 
    radius = ~ifelse(mag >= 5.5, 10, 0), 
    stroke = TRUE, 
    weight = ~ifelse(mag >= 5.5, 1, 0), 
    color = "black", 
    fillColor = "red", 
    fillOpacity = ~ifelse(mag >= 5.5, 0.3, 0)) 

# 또 다른 재조정
leaflet(data = quakes) %>% 
  addTiles() %>% 
  addCircleMarkers( 
    ~long, ~lat, 
    radius = ~ifelse(mag >= 6, 10, ifelse(mag >= 5.5, 5, 0)), # ifelse의 중첩 사용법
    stroke = TRUE, 
    weight = ~ifelse(mag >= 5.5, 1, 0), 
    color = ~ifelse(mag >= 5.5, 'black', NA), 
    fillColor = ~ifelse(mag >= 6, 'red', ifelse(mag >= 5.5, 'green', NA)), #ifelse의 중첩 사용법
    fillOpacity = ~ifelse(mag >= 5.5, 0.3, 0))


# 6.4 우리나라 행정경계 지도 
# install.packages("ggplot2") 
# install.packages("rgdal") 
library(ggplot2) 
library(rgdal)

shapefile_path <- "C:/Users/9902k/Documents/Z_NGII_N3A_G0010000.shp"

map <- readOGR(dsn = shapefile_path)

df_map <- fortify(map) 
head(df_map) 

# 흑백/다각형으로 지도 그리기기
ggplot(data = df_map, 
       aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white", color = "black") 

ggplot(data = df_map, 
       aes(x = long, y = lat, group = group, fill = id)) + 
  geom_polygon(alpha = 0.3, color = "black") + 
  theme(legend.position = "none") 


# install.packages("ggplot2") 
# install.packages("rgdal") 
library(ggplot2) 
library(rgdal) 

map <- readOGR('Z_NGII_N3A_G0010000.shp') 

# 위경도를 알기 쉽게 변환(표준을 변환)
crs <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs') 
map <- spTransform(map, CRSobj = crs) 
df_map <- fortify(map) 

ggplot(data = df_map, 
       aes(x = long, y = lat, group = group, fill = id)) + 
  geom_polygon(alpha = 0.3, color = "black") + 
  theme(legend.position = "none") + 
  labs(x="경도", y="위도")



# 6.5 행정경계 지도를 이용한 국내 지진 분포 파악
# 전처리: "북한", "N", "E" 없애기기
# install.packages("ggplot2") 
#install.packages("openxlsx") 
# install.packages("rgdal") 
library(ggplot2) 
library(openxlsx) 
library(rgdal) 

df <- read.xlsx(file.choose(), sheet = 1, startRow = 4, colNames = FALSE) 
head(df) 

idx <- grep("^북한", df$X8) # x8 컬럼에서 북한으로 시작하는 문자열을 찾아서 인덱스(순서) 반환 -> 반환되는 인덱스값의 위치에서 8번째 컬럼이 북한으로 시작함
# ^북한이 아니라 북한 이면 문자열 내에 북한이 들어있기만 하면 인덱스 반환함. 만약 $북한이라면 북한으로 끝나는 문자열임
df[idx, 'X8'] # 데이터프레임화
df <- df[-idx, ] # 해당 인덱스를 제거한다 / idx번째 라인은 제거한다

# 6, 7번째에 있는 N과 E를 뺀다(""로 바꾼다다)
df[,6] <- gsub("N", "", df[,6]) 
df[,7] <- gsub("E", "", df[,7])

# 6, 7번째 데이터를 숫자로 바꾼다
df[,6] <- as.numeric(df[,6]) 
df[,7] <- as.numeric(df[,7]) 

shapefile_path <- "C:/Users/9902k/Documents/Z_NGII_N3A_G0010000.shp"
map <- readOGR(dsn = shapefile_path) 
crs <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs') 
map <- spTransform(map, CRSobj = crs) 

df_map <- fortify(map) 

ggplot() + 
  geom_polygon(data = df_map, 
               aes(x = long, y = lat, group = group), 
               fill = "white", alpha=0.5, 
               color="black") + 
  geom_point(data=df, 
             aes(x=X7, y=X6, size=X3), 
             shape=21, color='black', 
             fill='red', alpha=0.3) + 
  theme(legend.position = "none") + 
  labs(title="지진분포", x="경도", y="위도")