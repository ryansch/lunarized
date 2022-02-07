local colorscheme = require("lunarized").colors
local run = require("shipwright").run
local kitty = require("shipwright.transform.contrib.kitty")
local overwrite = require("shipwright.transform.overwrite")

run(colorscheme,
  -- Generage kitty input format
  function (colors)
    return {
      fg = colors.base0,
      bg = colors.base03,
      cursor_fg = colors.base03,
      cursor_bg = colors.base0,
      selection_fg = colors.base01,
      selection_bg = colors.base03,

      url = colors.violet,

      black = colors.base03,
      red = colors.red,
      green = colors.green,
      yellow = colors.yellow,
      blue = colors.blue,
      magenta = colors.magenta,
      cyan = colors.cyan,
      white = colors.base3,
      bright_black = colors.base01,
      bright_red = colors.orange,
      bright_green = colors.base01,
      bright_yellow = colors.base00,
      bright_blue = colors.base0,
      bright_magenta = colors.violet,
      bright_cyan = colors.base0,
      bright_white = colors.base3,

      titlebar = colors.base03.darken(15),
      tab_active_fg = colors.base1,
      tab_active_bg = colors.base02,
      tab_inactive_fg = colors.base0,
      tab_inactive_bg = colors.base03.darken(30),

      name = "Lunarized",
      author = "Ryan Schlesinger",
      upstream = "https://github.com/ryansch/lunarized",
      license = "MIT",
    }
  end,

  -- now pass to kitty
  {kitty},

  -- and now we can write, either to share or to our local config
  {overwrite, vim.fn.expand("~/.dotfiles/kitty/lunarized.conf")})
