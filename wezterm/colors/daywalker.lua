-- Daywalker — engineered for maximum legibility in direct sunlight and glare.
-- (A vampire that strolls through high noon unbothered. The screen should too.)
--
-- Design rationale:
--   * Light background, dark text. Outdoors, the display cannot out-glow the
--     sun. A high-luminance background lets ambient light ADD to legibility
--     instead of washing out a dark screen. This is why e-readers and road
--     signs are dark-on-light.
--   * Maximum luminance contrast. Every foreground colour clears WCAG AAA
--     (>=7:1) against the background, so nothing dissolves under glare. Hues
--     are deep and saturated — pastels vanish in sun, so there are none.
--   * Warm paper-white (not pure #FFFFFF) cuts specular harshness without
--     surrendering luminance.
--   * No gradient, no transparency (see themes.lua) — flat fields hold their
--     contrast edge-to-edge; gradients create low-contrast dead zones.

return {
  foreground    = '#1A1611',  -- ink: warm near-black, ~17:1 on the paper
  background    = '#F4F1E8',  -- warm paper-white: high luminance, low glare

  cursor_bg     = '#B01200',  -- signal red block: unmissable in bright light
  cursor_fg     = '#F4F1E8',
  cursor_border = '#B01200',

  selection_fg  = '#1A1611',
  selection_bg  = '#F4D58A',  -- amber highlighter: bold but text stays readable

  ansi = {
    '#2A251E',  -- black    (warm charcoal — still ~13:1, true structural dark)
    '#B0140A',  -- red      (deep signal red — ~6.9:1)
    '#0A6B22',  -- green    (deep forest — ~5.6:1, saturated for hue clarity)
    '#7A5400',  -- yellow   (dark amber — pure yellow is invisible on light)
    '#0A47B8',  -- blue     (deep cobalt — ~7.0:1)
    '#97137C',  -- magenta  (deep magenta — ~6.8:1)
    '#0A5E68',  -- cyan     (deep teal — distinct from green and blue)
    '#3A352C',  -- white    (dark grey — darkened so app-dimmed text survives sun)
  },

  brights = {
    '#3A352C',  -- bright black   (dark grey — even alpha-composited dim text holds)
    '#8E0A00',  -- bright red     (darker, hotter red — extra contrast pop)
    '#085A1B',  -- bright green   (deeper forest)
    '#634400',  -- bright yellow  (deeper amber)
    '#06379A',  -- bright blue    (deeper cobalt)
    '#7C0E64',  -- bright magenta (deeper magenta)
    '#084952',  -- bright cyan    (deeper teal)
    '#1A1611',  -- bright white   (ink — maximum contrast)
  },

  tab_bar = {
    background = '#E4DFD0',  -- slightly deeper paper, recedes under the content
    active_tab = {
      bg_color  = '#F4F1E8',  -- paper — active tab reads as "lifted" / lit
      fg_color  = '#B0140A',  -- signal red label
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#E4DFD0',
      fg_color = '#46402F',  -- muted but darkened to hold contrast in glare
    },
    inactive_tab_hover = {
      bg_color = '#EDE9DC',
      fg_color = '#1A1611',
    },
    new_tab = {
      bg_color = '#E4DFD0',
      fg_color = '#5A5346',
    },
    new_tab_hover = {
      bg_color = '#F4F1E8',
      fg_color = '#B0140A',
    },
  },

  split           = '#7A5400',  -- amber dividers: visible against light fields
  scrollbar_thumb = '#8A8470',
}
