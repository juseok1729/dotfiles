local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_domain = 'WSL:Ubuntu' -- 위에서 확인한 이름 그대로

config.front_end = "WebGpu"
config.window_background_opacity = 0.9
config.win32_system_backdrop = 'Auto'
config.colors = {
  background = '#0c0c14',
}

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.window_padding = { left = 8, right = 8, top = 4, bottom = 0 }

config.window_close_confirmation = 'NeverPrompt'

return config
