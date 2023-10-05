# 5-1. 첨부된 꽃 사진 (flo4.png)과 산 사진(mount.jpg)을 확인해 보세요.
library("magick")

flower <- image_read("flo4.png")
mount <- image_read("mount.jpg")

flower <- image_scale(flower, "50x50!")
mount <- image_scale(mount, "1000x525!")

fus <- image_composite(mount, flower, offset = geometry_point(100, 400))
print(fus)