local lush = require('lush')
local hsl = lush.hsl

local colors = {
  base03 = hsl(193, 96, 11),
  base02 = hsl(192, 83, 14),
  base01 = hsl(195, 16, 40),
  base00 = hsl(195, 14, 45),
  base0 = hsl(187, 8, 55),
  base1 = hsl(184, 7, 60),
  base2 = hsl(48, 41, 88),
  base3 = hsl(44, 87, 94),
  yellow = hsl(46, 100, 35),
  orange = hsl(18, 80, 44),
  red = hsl(1, 72, 52),
  magenta = hsl(331, 64, 52),
  violet = hsl(238, 44, 60),
  blue = hsl(205, 69, 49),
  cyan = hsl(175, 58, 40),
  green = hsl(78, 94, 32),
}

return {
  colors = colors,
}
