# 5-2. 첨부된 태양 사진(sun.jfif)와 산 사진(mount3.jpg)을 확인해 보세요.
# 두 사진의 크기를 조정한 후, 마치 태양이 산 위에 걸린 느낌을 주는 위치에 태양을 합성시켜 보세요. 
library("magick")

sun <- image_read("sun.jfif")
mount <- image_read("mount3.jpg")

sun <- image_scale(sun, "75x75!")
mount <- image_scale(mount, "740x400!")

fus <- image_composite(mount, sun, offset = geometry_point(120, 150))
print(fus)