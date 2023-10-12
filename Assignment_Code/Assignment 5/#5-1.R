# 5-1. 첨부된 꽃 사진 (flo4.png)과 산 사진(mount.jpg)을 확인해 보세요.
# 두 사진의 크기를 적당히 조정한 후 산 사진 위 적당한 위치에 꽃을 합성시켜 주세요.
library("magick")

flower <- image_read("flo4.png")
mount <- image_read("mount.jpg")
flower
mount

flower <- image_scale(flower, "50x50!")
mount <- image_scale(mount, "1000x525!")

fus <- image_composite(mount, flower, offset = geometry_point(100, 400))
print(fus)