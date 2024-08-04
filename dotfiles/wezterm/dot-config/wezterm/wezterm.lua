local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 10.0
config.color_scheme = 'SpaceGray Eighties Dull'
config.enable_tab_bar = false
config.keys = {
  -- Turn off the default ALT-<CR> action
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return config
