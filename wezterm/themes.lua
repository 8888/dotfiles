local wezterm = require 'wezterm'

local pixelgrim    = require('colors.pixelgrim')
local squirrelsong = require('colors.squirrelsong_dark')
local candywave    = require('colors.candywave')
local vortexbloom  = require('colors.vortexbloom')

local themes = {
  pixelgrim = {
    -- Identity
    color_scheme_name = 'PixelGrim',
    color_scheme_table = pixelgrim,
    -- Font
    font = wezterm.font_with_fallback({
      { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
    }),
    font_size   = 14.0,
    line_height = 1.2,
    -- Window
    window_padding             = { left = 12, right = 12, top = 12, bottom = 12 },
    window_background_opacity  = 1.0,
    -- Cursor
    default_cursor_style = 'BlinkingBlock',
    -- Inactive pane
    inactive_pane_hsb = { saturation = 0.8, brightness = 0.55 },
  },

  squirrelsongdark = {
    color_scheme_name  = 'SquirrelsongDark',
    color_scheme_table = squirrelsong,
    font = wezterm.font_with_fallback({
      { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
    }),
    font_size   = 14.0,
    line_height = 1.2,
    window_padding            = { left = 12, right = 12, top = 12, bottom = 12 },
    window_background_opacity = 1.0,
    default_cursor_style      = 'SteadyBar',
    inactive_pane_hsb         = { saturation = 0.9, brightness = 0.65 },
  },

  candywave = {
    color_scheme_name  = 'CandyWave',
    color_scheme_table = candywave,
    font = wezterm.font_with_fallback({
      { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
    }),
    font_size   = 13.5,
    line_height = 1.1,
    window_padding            = { left = 10, right = 10, top = 10, bottom = 10 },
    window_background_opacity = 1.0,
    -- Cotton candy storm: deep storm-pink core vignettes outward through violet
    -- into midnight blue at the edges — retro squall closing in.
    window_background_gradient = {
      orientation   = { Radial = { cx = 0.5, cy = 0.4, radius = 0.9 } },
      colors        = { '#2A0A26', '#1A0D2E', '#0A1A3A', '#040C20' },
      interpolation = 'CatmullRom',
      blend         = 'LinearRgb',
      noise         = 72,
    },
    default_cursor_style = 'BlinkingBlock',
    inactive_pane_hsb    = { saturation = 0.75, brightness = 0.5 },
  },

  vortexbloom = {
    color_scheme_name  = 'VortexBloom',
    color_scheme_table = vortexbloom,
    font = wezterm.font_with_fallback({
      { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
    }),
    font_size   = 14.0,
    line_height = 1.1,
    window_padding            = { left = 10, right = 10, top = 10, bottom = 10 },
    window_background_opacity = 1.0,
    window_background_gradient = {
      orientation   = { Radial = { cx = 0.5, cy = 0.45, radius = 0.85 } },
      colors        = { '#2E1460', '#1A0C3C', '#0E0A28', '#060510' },
      interpolation = 'CatmullRom',
      blend         = 'LinearRgb',
      noise         = 40,
    },
    default_cursor_style = 'BlinkingBlock',
    inactive_pane_hsb    = { saturation = 0.7, brightness = 0.5 },
  },
}

return themes
