-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 13
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.native_macos_fullscreen_mode = true

config.color_scheme = "Catppuccin Frappe";

config.window_padding = {
  left = "1pt",
  right = "1pt",
  top = "0pt",
  bottom = "0pt",
}

-- config.window_decorations = "MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR | TITLE | RESIZE"

-- Spawn a fish shell in login mode
config.default_prog = { "sh", "-c", "~/.config/bin/shell/shell --login --interactive" }

-- Finally, return the configuration to wezterm:
return config
