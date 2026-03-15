local wezterm = require 'wezterm'

local pixelgrim    = require('colors.pixelgrim')
local squirrelsong = require('colors.squirrelsong_dark')
local candywave    = require('colors.candywave')

local themes = {
  PixelGrim = {
    -- Identity
    color_scheme_name = 'PixelGrim',
    color_scheme_table = pixelgrim,
    -- Font
    font = wezterm.font_with_fallback({
      { family = 'GeistMono Nerd Font', weight = 'Regular' },
      { family = 'JetBrains Mono',      weight = 'Regular' },
    }),
    font_size   = 14.0,
    line_height = 1.05,
    -- Window
    window_padding             = { left = 8, right = 8, top = 8, bottom = 8 },
    window_background_opacity  = 0.95,
    -- Cursor
    default_cursor_style = 'BlinkingBlock',
    -- Inactive pane
    inactive_pane_hsb = { saturation = 0.8, brightness = 0.4 },
  },

  SquirrelsongDark = {
    color_scheme_name  = 'SquirrelsongDark',
    color_scheme_table = squirrelsong,
    font = wezterm.font_with_fallback({
      { family = 'GeistMono Nerd Font', weight = 'Regular' },
      { family = 'JetBrains Mono',      weight = 'Regular' },
    }),
    font_size   = 14.0,
    line_height = 1.2,
    window_padding            = { left = 12, right = 12, top = 12, bottom = 12 },
    window_background_opacity = 1.0,
    default_cursor_style      = 'SteadyBar',
    inactive_pane_hsb         = { saturation = 0.9, brightness = 0.65 },
  },

  CandyWave = {
    color_scheme_name  = 'CandyWave',
    color_scheme_table = candywave,
    font = wezterm.font_with_fallback({
      { family = 'DepartureMono Nerd Font', weight = 'Regular' },
      { family = 'JetBrains Mono',          weight = 'Regular' },
    }),
    font_size   = 13.5,
    line_height = 1.0,
    window_padding            = { left = 6, right = 6, top = 6, bottom = 6 },
    window_background_opacity = 0.97,
    -- Radial vignette: warm amethyst core fades to near-void black at the
    -- edges — lit stage with darkness closing in. Slightly high center (cy=0.4)
    -- so the glow sits behind the text area rather than dead center.
    window_background_gradient = {
      orientation   = { Radial = { cx = 0.5, cy = 0.4, radius = 0.9 } },
      colors        = { '#2A0A32', '#1A0D2E', '#080412' },
      interpolation = 'CatmullRom',
      blend         = 'LinearRgb',
      noise         = 58,
    },
    default_cursor_style = 'BlinkingBlock',
    inactive_pane_hsb    = { saturation = 0.75, brightness = 0.5 },
  },
}

return themes
