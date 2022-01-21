local colors = require('lunarized').colors

return {
  normal = {
    a = { fg = colors.base03.hex, bg = colors.blue.hex, gui = 'bold' },
    b = { fg = colors.base1.hex, bg = colors.base02.hex },
    c = { fg = colors.base1.hex, bg = colors.base02.hex },
  },
  insert = { a = { fg = colors.base03.hex, bg = colors.green.hex, gui = 'bold' } },
  visual = { a = { fg = colors.base03.hex, bg = colors.magenta.hex, gui = 'bold' } },
  replace = { a = { fg = colors.base03.hex, bg = colors.red.hex, gui = 'bold' } },
  inactive = {
    a = { fg = colors.base0.hex, bg = colors.base02.hex, gui = 'bold' },
    b = { fg = colors.base03.hex, bg = colors.base00.hex },
    c = { fg = colors.base01.hex, bg = colors.base02.hex },
  },
}
