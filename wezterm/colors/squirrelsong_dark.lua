-- Squirrelsong Dark — by Artem Sapegin
-- https://sapegin.me/squirrelsong/
return {
  foreground    = '#bfac99',
  background    = '#292019',

  cursor_bg     = '#bfac99',
  cursor_fg     = '#292019',
  cursor_border = '#bfac99',

  selection_fg  = '#bfac99',
  selection_bg  = '#574538',

  ansi = {
    '#5b4839',  -- black
    '#ac493e',  -- red
    '#558240',  -- green
    '#ceb250',  -- yellow
    '#5993c2',  -- blue
    '#7f61b3',  -- magenta
    '#4f9593',  -- cyan
    '#bfac99',  -- white
  },

  brights = {
    '#695444',  -- bright black
    '#ce574a',  -- bright red
    '#709855',  -- bright green
    '#e2c358',  -- bright yellow
    '#63a2d6',  -- bright blue
    '#9672d4',  -- bright magenta
    '#72aaa8',  -- bright cyan
    '#edd5be',  -- bright white
  },

  tab_bar = {
    background = '#292019',
    active_tab = {
      bg_color  = '#4d3b2e',
      fg_color  = '#bfac99',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#292019',
      fg_color = '#bfac99',
    },
    inactive_tab_hover = {
      bg_color = '#453327',
      fg_color = '#bfac99',
    },
    new_tab = {
      bg_color = '#292019',
      fg_color = '#bfac99',
    },
    new_tab_hover = {
      bg_color = '#453327',
      fg_color = '#bfac99',
    },
  },

  split           = '#453327',
  scrollbar_thumb = '#574538',
}
