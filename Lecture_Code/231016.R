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