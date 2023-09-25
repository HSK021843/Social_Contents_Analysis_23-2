library("magick")

flower <- image_read("flo4.png")
mount < image_read("mount.png")

flower <- image_scale(flower, "50x50!")
mount <- image_scale(mount, "600x150!")

fus <- image_composite(flower, mount, offset = geometry_point(120, 30))
print(fus)


