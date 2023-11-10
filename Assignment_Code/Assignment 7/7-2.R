# 7-2. 평소 자주 방문하는 웹 사이트에 가서 왠지 긁어오고 싶은 정보를 찾아 한번 긁어보세요. 그리고 결과를 보여주세요. 
library(rvest)

url <- "https://meeco.kr/ITplus"
html <- read_html(url)

titles <- html_nodes(html, ".title_moa") %>%
  html_text()


formatted_titles <- gsub("\r|\n|\t", "", titles)
formatted_titles <- gsub("\"", "", formatted_titles)

formatted_titles
 