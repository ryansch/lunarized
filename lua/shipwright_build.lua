local colorscheme = require("lunarized").colors

run(colorscheme,
  -- Generage kitty input format
  function (colors)
    return {
      fg = colors.base0,
      bg = colors.base02,
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
      bright_black = colors.base03,
      bright_red = colors.red,
      bright_green = colors.green,
      bright_yellow = colors.yellow,
      bright_blue = colors.blue,
      bright_magenta = colors.magenta,
      bright_cyan = colors.cyan,
      bright_white = colors.base3,
      name = "Lunarized",
      author = "Ryan Schlesinger",
      upstream = "https://github.com/ryansch/lunarized",
      license = "MIT",
    }
  end,

  -- now we can pass to alacritty, note that the transform accepts a name,
  -- so we use a table with the transform and it's argument.
  {contrib.kitty},

  -- and now we can write, either to share or to our local config
  {overwrite, "/home/ubuntu/.dotfiles/kitty/lunarized.conf"})
