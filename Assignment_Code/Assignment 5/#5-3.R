# 5-3. 2번에서 만든 사진에서 마치 해가 뜨는 것처럼 보이도록 태양을 위쪽으로 움직여 보세요. 
library("magick")

sun <- image_read("sun.jfif")
mount <- image_read("mount3.jpg")

sun <- image_scale(sun, "75x75!")
mount <- image_scale(mount, "740x400!")

x = 120
y = 150

while (TRUE) {
  posit = geometry_point(x, y)
  fus <- image_composite(mount, sun, offset = posit
  )
  print(fus)
  Sys.sleep(0.1)
  if(x == 300)
    break
  x <- x + 20
  y <- y - 15
}
