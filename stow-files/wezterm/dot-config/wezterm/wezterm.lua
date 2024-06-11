local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'Fira Code Nerd Font'
config.font_size = 10
config.enable_tab_bar = false

config.colors = {

  foreground = "#868686",
  background = "#1F1F1F",
  cursor_bg = "#828282",
  cursor_fg = "#868686",
  cursor_border = "#828282",
  selection_fg = "#939393",
  selection_bg = "#222222",

  ansi = {"#131313", "#9E9E9E", "#696969", "#D5D5D5", "#828282", "#E4E4E4", "#BABABA", "#868686"},
  brights = {"#585858", "#9E9E9E", "#696969", "#D5D5D5", "#828282", "#E4E4E4", "#BABABA", "#868686"},

}

return config