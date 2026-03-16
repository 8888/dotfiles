local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Theme — controlled by ~/.wezterm_theme (use `weztheme` to switch)
local themes = require('themes')
local theme_file = wezterm.home_dir .. '/.wezterm_theme'
wezterm.add_to_config_reload_watch_list(theme_file)
local function active_theme()
  local f = io.open(theme_file, 'r')
  if f then
    local name = f:read('*l')
    f:close()
    if themes[name] then return name end
  end
  return 'CandyWave'
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

-- Tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Show cwd + workspace name in right status
wezterm.on('update-right-status', function(window, pane)
  local cwd = ''
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local path = cwd_uri.file_path
    -- Shorten home directory to ~
    path = path:gsub('^' .. os.getenv('HOME'), '~')
    cwd = path
  end

  window:set_right_status(wezterm.format({
    { Foreground = { AnsiColor = 'Silver' } },
    { Text = cwd .. '  ' },
    { Attribute = { Intensity = 'Bold' } },
    { Foreground = { AnsiColor = 'Fuchsia' } },
    { Text = window:active_workspace() .. '  ' },
  }))
end)

-- Scrollback / bell
config.scrollback_lines = 50000
config.audible_bell = 'Disabled'

-- Leader key: Ctrl+Space, then a single key
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1500 }

-- Keybindings (all triggered after Ctrl+Space leader)
config.keys = {
  -- Panes: split
  { key = '\\', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-',  mods = 'LEADER', action = wezterm.action.SplitVertical   { domain = 'CurrentPaneDomain' } },
  -- Panes: navigate (vim-style)
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },
  -- Panes: zoom / close
  { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },
  { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true } },

  -- Tabs: create / navigate
  { key = 't', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = ',', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
  { key = '.', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
  -- Windows: new
  { key = 'Enter', mods = 'LEADER', action = wezterm.action.SpawnWindow },

  -- Workspaces: switch / manage
  { key = ']', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(1) },
  { key = '[', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(-1) },
  { key = 'w', mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' } },
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = 'New workspace name:',
      action = wezterm.action_callback(function(window, pane, name)
        if name then
          window:perform_action(wezterm.action.SwitchToWorkspace { name = name }, pane)
        end
      end),
    },
  },
}

return config
