library("magick")

sun <- image_read("sun.jfif")
mount <- image_read("mount3.jpg")

sun <- image_scale(sun, "75x75!")
mount <- image_scale(mount, "740x400!")

x = 120
y = 150


img_list <- list()

while (TRUE) {
  posit = geometry_point(x, y)
  fus <- image_composite(mount, sun, offset = posit)
  
  img_list <- c(img_list, fus)
  
  if(x == 300)
    break
  
  x <- x + 20
  y <- y - 15
}

img <- image_join(img_list)
img <- image_animate(img, loop = 1)

image_write(img, "result.gif")
 