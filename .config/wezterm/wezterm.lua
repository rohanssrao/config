local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('Liga SFMono Nerd Font', { weight = 'Medium' })

config.enable_scroll_bar = true
config.scrollback_lines = 10000

config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"

config.initial_rows = 40
config.initial_cols = 140

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 50

config.xcursor_theme = 'Adwaita'
config.xcursor_size = 24

-- Hide scrollbar in interactive programs
wezterm.on('update-status', function(window, pane)
  window:set_config_overrides( { enable_scroll_bar = not pane:is_alt_screen_active() } )
end)

config.keys = {
  { mods = 'ALT', key = 't', action = wezterm.action.SpawnTab 'CurrentPaneDomain', },
  { mods = 'ALT', key = 'w', action = wezterm.action.CloseCurrentTab { confirm = false }, },
}

-- Alt+1-9 tab switch
for i = -1, 7 do
  table.insert(config.keys, { mods = 'ALT', key = i == -1 and '9' or tostring(i + 1), action = wezterm.action.ActivateTab(i), })
end

local c_0  = '#111318'
local c_1  = '#BF616A'
local c_2  = '#A3BE8C'
local c_3  = '#EBCB8B'
local c_4  = '#81A1C1'
local c_5  = '#B48EAD'
local c_6  = '#88C0D0'
local c_7  = '#E5E9F0'
local c_8  = '#3B4252'
local c_9  = '#BF616A'
local c_10 = '#A3BE8C'
local c_11 = '#EBCB8B'
local c_12 = '#81A1C1'
local c_13 = '#B48EAD'
local c_14 = '#8FBCBB'
local c_15 = '#ECEFF4'

config.colors = {
  foreground   = '#ffffff',
  background   = c_0;
  cursor_bg    = c_15,
  selection_bg = '#ffffff',
  selection_fg = '#000000',
  ansi    = { c_0, c_1, c_2, c_3, c_4, c_5, c_6, c_7 },
  brights = { c_8, c_9, c_10, c_11, c_12, c_13, c_14, c_15 },
  tab_bar = { background = c_0 },
}

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local grad_0 = tab.is_active and '#48494d' or '#333438'
  local grad_1 = tab.is_active and '#7f8083' or '#555658'
  local grad_2 = tab.is_active and '#b6b7b8' or '#777778'
  local bg     = tab.is_active and '#eeeeee' or '#999999'
  return {
    { Background = { Color = grad_0 } }, { Text = ' ' },
    { Background = { Color = grad_1 } }, { Text = ' ' },
    { Background = { Color = grad_2 } }, { Text = ' ' },

    { Background = { Color = bg } },
    { Foreground = { Color = c_0 } },
    { Text = ' ' .. tab.active_pane.title .. ' ' },

    { Background = { Color = grad_2 } }, { Text = ' ' },
    { Background = { Color = grad_1 } }, { Text = ' ' },
    { Background = { Color = grad_0 } }, { Text = ' ' },
    
    { Background = { Color = c_0 } }, { Text = ' ' },
  }
end)

return config
