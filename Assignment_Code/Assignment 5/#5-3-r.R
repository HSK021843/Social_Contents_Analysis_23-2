library("magick")

sun <- image_read("sun.jfif")
mount <- image_read("mount3.jpg")

sun <- image_scale(sun, "75x75!")
mount <- image_scale(mount, "740x400!")

x = 120
y = 150

# 이미지 객체 목록을 초기화합니다
img_list <- list()

while (TRUE) {
  posit = geometry_point(x, y)
  fus <- image_composite(mount, sun, offset = posit)
  
  # 이미지를 목록에 추가합니다
  img_list <- c(img_list, fus)
  
  if(x == 300)
    break
  
  x <- x + 20
  y <- y - 15
}

# 이미지 객체 목록을 하나의 magick 이미지 객체로 결합합니다
img <- image_join(img_list)

# 이미지 객체를 애니메이션 GIF로 변환하고 저장합니다
img <- image_animate(img)
image_write(img, "result.gif")
 