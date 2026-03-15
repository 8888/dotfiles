return {
  foreground    = '#B8FF70',  -- neon phosphor: electric green, alive on screen
  background    = '#0D1228',  -- deep vortex indigo

  cursor_bg     = '#AAFF00',  -- acid chartreuse: blazing cursor
  cursor_fg     = '#0D1228',  -- deep vortex indigo
  cursor_border = '#AAFF00',

  selection_fg  = '#E0FFC0',  -- bright phosphor
  selection_bg  = '#3A1A6E',  -- vivid violet — punchy selection

  ansi = {
    '#1A1E3A',  -- black      (indigo smoke — cosmic)
    '#FF3D20',  -- red        (vermillion blaze — hotter, more orange-red)
    '#50FF22',  -- green      (radioactive lime — the spiral's core energy)
    '#FFD000',  -- yellow     (solar flare — vivid warm gold)
    '#4455FF',  -- blue       (deep electric indigo — saturated)
    '#BF30FF',  -- magenta    (ultraviolet — intense purple)
    '#00E8B0',  -- cyan       (vortex emerald — vivid teal-green)
    '#D0F0A0',  -- white      (phosphor lime)
  },

  brights = {
    '#5555A8',  -- bright black   (twilight indigo — comments)
    '#FF6040',  -- bright red     (warm coral flare)
    '#80FF50',  -- bright green   (neon chartreuse — extra pop)
    '#FFE040',  -- bright yellow  (electric gold)
    '#7088FF',  -- bright blue    (periwinkle flare)
    '#D060FF',  -- bright magenta (orchid pulse)
    '#30FFC8',  -- bright cyan    (bright mint — sparkling)
    '#F0FFD8',  -- bright white   (green-kissed white)
  },

  tab_bar = {
    background = '#080C1A',  -- abyss — deepest void
    active_tab = {
      bg_color  = '#1C1040',  -- dark violet — active tab glows purple
      fg_color  = '#AAFF00',  -- acid chartreuse
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#0D1228',  -- vortex indigo
      fg_color = '#5C6C4A',  -- muted sage
    },
    inactive_tab_hover = {
      bg_color = '#1A1E3A',
      fg_color = '#B8FF70',
    },
    new_tab = {
      bg_color = '#0D1228',
      fg_color = '#5C6C4A',
    },
    new_tab_hover = {
      bg_color = '#1C1040',
      fg_color = '#AAFF00',
    },
  },

  split           = '#BF30FF',  -- ultraviolet pane dividers — visible, on-theme
  scrollbar_thumb = '#3A1A6E',  -- vivid violet
}
