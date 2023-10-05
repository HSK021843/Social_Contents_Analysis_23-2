library("magick")

flower <- image_read("flo4.png")
mount <- image_read("mount.jpg")

flower <- image_scale(flower, "50x50!")
mount <- image_scale(mount, "1600x1150!")

fus <- image_composite(flower, mount, offset = geometry_point(120, 30))
print(fus)



sun <- image_read("sun.jfif")
mount <- image_read("mount3.jpg")

flower <- image_scale(sun, "50x50!")
mount <- image_scale(mount, "600x150!")

fus <- image_composite(sun, mount, offset = geometry_point(120, 30))
print(fus)



sun <- image_read("sun.jfif")
mount <- image_read("mount3.jpg")

flower <- image_scale(sun, "50x50!")
mount <- image_scale(mount, "600x150!")

while (TRUE) {
  posit = geometry_point(120, 30)
  fus <- image_composite(sun, mount, offset = posit
  )
  print(img)
  Sys.sleep(0, 1)
  if(x == 400)
    break
  x <- x + 20
  y <- y - 4
}