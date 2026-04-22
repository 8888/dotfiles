local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Theme — controlled by ~/.wezterm_theme (use `weztheme` to switch)
local themes = require('themes')
local theme_file = wezterm.home_dir .. '/.wezterm_theme'
wezterm.add_to_config_reload_watch_list(theme_file)
local function active_theme()
  local f = io.open(theme_file, 'r')
  if f then
    local name = f:read('*l'):lower()
    f:close()
    if themes[name] then return name end
  end
  return 'candywave'
end
local THEME = themes[active_theme()]

-- Font
config.font        = THEME.font
config.font_size   = THEME.font_size
config.line_height = THEME.line_height

-- Color scheme
config.color_schemes = {
  [THEME.color_scheme_name] = THEME.color_scheme_table,
}
config.color_scheme = THEME.color_scheme_name

-- Window
config.window_padding            = THEME.window_padding
config.window_decorations        = 'TITLE | RESIZE'
config.window_background_opacity = THEME.window_background_opacity
config.inactive_pane_hsb         = THEME.inactive_pane_hsb
if THEME.window_background_gradient then
  config.window_background_gradient = THEME.window_background_gradient
end

-- Cursor
config.default_cursor_style = THEME.default_cursor_style

-- Tab bar — hidden, tmux handles multiplexing
config.hide_tab_bar_if_only_one_tab = true

-- Bell
config.audible_bell = 'Disabled'

-- Leader key: Ctrl+Space (kept for WezTerm-only utilities)
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1500 }

config.keys = {
  -- Cheat sheet: opens in a temporary tab, press any key to dismiss
  {
    key = '?',
    mods = 'LEADER',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'sh', '-c', 'cat ~/.config/wezterm/cheatsheet.txt; read -n1 -s' },
    },
  },
  -- ASCII animation
  {
    key = '!',
    mods = 'LEADER',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'sh', '-c', '~/.config/wezterm/animate.sh' },
    },
  },
}

return config
