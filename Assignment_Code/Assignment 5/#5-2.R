library("magick")

sun <- image_read("sun.jfif")
mount <- image_read("mount3.jpg")

sun <- image_scale(sun, "75x75!")
mount <- image_scale(mount, "740x400!")

fus <- image_composite(mount, sun, offset = geometry_point(120, 150))
print(fus)