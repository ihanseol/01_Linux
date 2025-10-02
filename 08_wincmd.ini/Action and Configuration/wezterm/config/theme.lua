local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Function to select a scheme based on system appearance
-- local function scheme_for_appearance(appearance)
--   if appearance:find 'Dark' then
--     return 'Catppuccin Mocha'  -- Your preferred dark theme
--   else
--     return 'Catppuccin Latte'  -- Your preferred light theme
--   end
-- end


-- config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- config.color_scheme = 'Adventure Time (Gogh)'

config.color_scheme = 'Apple Classic'
return config