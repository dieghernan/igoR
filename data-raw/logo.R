library(hexSticker)
# https://github.com/GuangchuangYu/hexSticker
# Add font
sysfonts::font_add_google("IBM Plex Sans", "ibm")

imgurl <- "data-raw/handshake.png"
p <- sticker(
  imgurl,
  package = "igoR",
  p_size = 35,
  p_y =1.5,
  s_x = 1,
  s_y = .88,
  s_width = 0.99,
  h_fill = "#0099ff",
  h_color = "#99d6ff",
  p_family = "ibm",
  p_color = "white",
  filename = "man/figures/logo.png"
)


par(mar=c(0,0,0,0))
plot(p)
