local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font_with_fallback({
  { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
  { family = 'JetBrains Mono',          weight = 'Regular' },
})
config.font_size = 13.0

-- Color scheme — change THEME to switch
local THEME = 'PixelGrim'
-- local THEME = 'SquirrelsongDark'
-- local THEME = 'Tokyo Night'

local pixelgrim       = require('colors.pixelgrim')
local squirrelsong    = require('colors.squirrelsong_dark')
config.color_schemes  = {
  ['PixelGrim']       = pixelgrim,
  ['SquirrelsongDark'] = squirrelsong,
}
config.color_scheme = THEME

-- Window
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
config.window_decorations = 'TITLE | RESIZE'
config.window_background_opacity = 1.0
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }

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

-- Workspace keybindings
config.keys = {
  -- Switch to next/prev workspace
  { key = ']', mods = 'CTRL|SHIFT', action = wezterm.action.SwitchWorkspaceRelative(1) },
  { key = '[', mods = 'CTRL|SHIFT', action = wezterm.action.SwitchWorkspaceRelative(-1) },
  -- Show workspace/session launcher
  { key = 'Space', mods = 'CTRL|SHIFT', action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' } },
  -- Prompt to create a new named workspace
  {
    key = 'n',
    mods = 'CTRL|SHIFT|ALT',
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
