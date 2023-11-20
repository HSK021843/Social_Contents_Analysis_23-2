# 7-1. 그림에 표시된 여섯 개의 뉴스 제목(과 신문 이름)을 스크래핑 해 보세요.
library(rvest)

clean_title <- function(title) {
  title <- title %>%
    html_text() %>%
    gsub("\r|\n|\t", "", .) %>%
    gsub("\"", "", .) %>%
    gsub("\\s+", " ", .) %>%
    gsub("^\\s+|\\s+$", "", .)
  return(title)
}


url <- "https://news.daum.net/society#1"
html <- read_html(url)

title1 <- html_nodes(html, ".item_column .tit_g")
formatted_title1 <- clean_title(title1)

title2 <- html_nodes(html, ".item_column .info_thumb")
formatted_title2 <- clean_title(title2)

df <- data.frame("기사제목" = formatted_title1, "신문이름" = formatted_title2)
df


