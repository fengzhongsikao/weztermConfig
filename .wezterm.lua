-- # terminal_config

-- 加载 wezterm API 和获取 config 对象
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-------------------- 颜色配置 --------------------
config.color_scheme = 'tokyonight_moon'
config.window_decorations = "TITLE | RESIZE"
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.show_tab_index_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

-- 设置字体和窗口大小
config.font = wezterm.font("Maple Mono NF CN")
config.font_size = 12
config.initial_cols = 140
config.initial_rows = 30

-- 设置默认的启动shell
config.set_environment_variables = {
  -- COMSPEC = 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe',
  COMSPEC = 'C:\\Users\\bidier\\AppData\\Local\\Programs\\nu\\bin\\nu.exe',
}

-------------------- 键盘绑定 --------------------
local act = wezterm.action

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = 'q',          mods = 'LEADER',     action = act.QuitApplication },

  { key = 'h',          mods = 'LEADER',     action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'v',          mods = 'LEADER',     action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'q',          mods = 'CTRL',       action = act.CloseCurrentPane { confirm = false } },

  { key = 'LeftArrow',  mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },

  -- CTRL + T 创建默认的Tab
  { key = 't',          mods = 'CTRL',       action = act.SpawnTab 'DefaultDomain' },
  -- CTRL + W 关闭当前Tab
  { key = 'w',          mods = 'CTRL',       action = act.CloseCurrentTab { confirm = false } },

  -- CTRL + SHIFT + 1 创建新Tab - WSL
  {
    key = '!',
    mods = 'CTRL|SHIFT',
    action = act.SpawnCommandInNewTab {
      domain = 'DefaultDomain',
      args = { 'wsl', '-d', 'Ubuntu-20.04' },
    }
  },
}

for i = 1, 8 do
  -- CTRL + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = act.ActivateTab(i - 1),
  })
end

-------------------- 鼠标绑定 --------------------
config.mouse_bindings = {
  -- copy the selection
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },

  -- Open HyperLink
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

-- 设置窗口透明度
-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 10
-- config.background = {
--   {
--     source = {
--       File = 'D:/壁纸/wallhaven-858lz1_2560x1600.png',
--     },
--   }
-- }

return config
