return {
  foreground    = '#E0DCE6',  -- text-body
  background    = '#120B18',  -- void

  cursor_bg     = '#05FFA1',  -- ectoplasm: neon mint, unmissable
  cursor_fg     = '#120B18',  -- void
  cursor_border = '#05FFA1',

  selection_fg  = '#E0DCE6',
  selection_bg  = '#3D2850',  -- between surface + overlay

  ansi = {
    '#1A0E24',  -- black      (void variant)
    '#FF5A8D',  -- red        (vampire — hot pink)
    '#05FFA1',  -- green      (ectoplasm — neon mint)
    '#FFB800',  -- yellow     (gold — cursed gold)
    '#58A6FF',  -- blue       (pip — github blue)
    '#A890FF',  -- magenta    (witchcraft — lavender)
    '#00D9F5',  -- cyan       (derived neon cyan)
    '#E0DCE6',  -- white      (text-body)
  },

  brights = {
    '#4A3358',  -- bright black   (medium purple — comments/dim)
    '#FF2A6D',  -- bright red     (original vampire — intense)
    '#00FF41',  -- bright green   (toxic — pure neon)
    '#FFD700',  -- bright yellow  (brighter gold)
    '#7DB8FF',  -- bright blue    (lighter pip)
    '#C4ADFF',  -- bright magenta (lighter witchcraft)
    '#05FFA1',  -- bright cyan    (ectoplasm)
    '#FFFFFF',  -- bright white
  },

  tab_bar = {
    background = '#0D0812',  -- darker than void, recedes
    active_tab = {
      bg_color  = '#221528',  -- surface
      fg_color  = '#A890FF',  -- witchcraft
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#120B18',  -- void
      fg_color = '#AEA2BA',  -- text-muted
    },
    inactive_tab_hover = {
      bg_color = '#1A0E24',
      fg_color = '#E0DCE6',
    },
    new_tab = {
      bg_color = '#120B18',
      fg_color = '#AEA2BA',
    },
    new_tab_hover = {
      bg_color = '#221528',
      fg_color = '#A890FF',
    },
  },

  split           = '#A890FF',  -- witchcraft pane dividers
  scrollbar_thumb = '#4A3358',
}
