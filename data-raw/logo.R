library(hexSticker)
# https://github.com/GuangchuangYu/hexSticker
# Add font
sysfonts::font_add_google("Architects Daughter", "architect")

imgurl <- "tools/readme/toro.png"
sticker(
  imgurl,
  package = "spanish",
  p_size = 25,
  p_y =1.61,
  s_x = 0.97,
  s_y = .85,
  s_width = .58,
  h_fill = "#f93740",
  h_color = "#fef34c",
  p_family = "architect",
  filename = "tools/readme/logo.png"
)

# To Readme

sticker(
  imgurl,
  package = "spanish",
  p_size = 25,
  p_y =1.61,
  s_x = 0.97,
  s_y = .85,
  s_width = .58,
  h_fill = "#f93740",
  h_color = "#fef34c",
  p_family = "architect",
  filename = "man/figures/logo.png"
)

# Favicons

pkgdown::build_favicons(overwrite = TRUE)

