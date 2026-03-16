return {
  foreground    = '#FAE8FA',  -- marshmallow: warm near-white with pink kiss
  background    = '#1A0D2E',  -- arcade night: deep violet-purple void

  cursor_bg     = '#FF2D9B',  -- bubblegum burst: hot pink, impossible to miss
  cursor_fg     = '#1A0D2E',  -- arcade night
  cursor_border = '#FF2D9B',

  selection_fg  = '#FAE8FA',
  selection_bg  = '#5A1F80',  -- candy grape: vivid selection pop

  ansi = {
    '#2D1050',  -- black      (deep violet — not pure black, dreamy)
    '#FF4DA6',  -- red        (raspberry — cotton candy red-pink)
    '#7AFFC8',  -- green      (mint cream — high contrast, reads clean)
    '#FFE566',  -- yellow     (candy corn — warm arcade gold)
    '#80CAFF',  -- blue       (periwinkle sky — cloud blue)
    '#FF79D8',  -- magenta    (cotton candy core — hot candy pink)
    '#AABEFF',  -- cyan       (periwinkle — more blue, less semantic confusion)
    '#FAE8FA',  -- white      (marshmallow)
  },

  brights = {
    '#9B78CC',  -- bright black   (lifted purple — comments more visible)
    '#FF1A8C',  -- bright red     (electric raspberry — intense)
    '#AAFFDD',  -- bright green   (bright mint — extra pop)
    '#FFF0A0',  -- bright yellow  (pastel gold — soft shimmer)
    '#B8DEFF',  -- bright blue    (cloud white-blue — airy)
    '#FFB0EC',  -- bright magenta (soft candy floss — lighter pink)
    '#E0C8FF',  -- bright cyan    (gossamer lavender — ethereal)
    '#FFFFFF',  -- bright white
  },

  tab_bar = {
    background = '#100720',  -- darker than arcade night, recedes into shadow
    active_tab = {
      bg_color  = '#3D1260',  -- grape candy — pops against shadow bar
      fg_color  = '#FF79D8',  -- cotton candy core
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#1A0D2E',  -- arcade night
      fg_color = '#A08BC0',  -- muted lavender
    },
    inactive_tab_hover = {
      bg_color = '#2D1050',
      fg_color = '#FAE8FA',
    },
    new_tab = {
      bg_color = '#1A0D2E',
      fg_color = '#A08BC0',
    },
    new_tab_hover = {
      bg_color = '#3D1260',
      fg_color = '#FF79D8',
    },
  },

  split           = '#FF79D8',  -- cotton candy pane dividers
  scrollbar_thumb = '#5A1F80',
}
