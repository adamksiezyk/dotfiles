local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Rose Pine color palette
local rose_pine = {
	base = "#191724",
	surface = "#1f1d2e",
	overlay = "#26233a",
	muted = "#6e6a86",
	subtle = "#908caa",
	text = "#e0def4",
	love = "#eb6f92",
	gold = "#f6c177",
	rose = "#ebbcba",
	pine = "#31748f",
	foam = "#9ccfd8",
	iris = "#c4a7e7",
	highlight_low = "#21202e",
	highlight_med = "#403d52",
	highlight_high = "#524f67",
}

-- Set color scheme
config.color_scheme = 'rose-pine'
config.colors = {
	cursor_border = "#ffffff",
	cursor_bg = "#ffffff",
	tab_bar = {
		background = rose_pine.base,
		active_tab = {
			bg_color = rose_pine.surface,
			fg_color = rose_pine.text,
		},
		inactive_tab = {
			bg_color = rose_pine.base,
			fg_color = rose_pine.muted,
		},
		inactive_tab_hover = {
			bg_color = rose_pine.overlay,
			fg_color = rose_pine.subtle,
		},
	},
}
config.window_background_opacity = 0.9

-- Set font
config.font = wezterm.font("JetBrainsMono Nerd Font")

-- Cursor style
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500

-- Set key bindings
config.leader = { key = "Space", mods = "CTRL" }
config.keys = {
	-- Workspaces
	{ key = 's', mods = 'LEADER',       action = act.ShowLauncherArgs { flags = "WORKSPACES" } },
	-- Rename workspace
	{
		key = '$',
		mods = 'LEADER|SHIFT',
		action = act.PromptInputLine {
			description = 'Enter new name for workspace',
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				end
			end),
		}
	},

	-- Tabs
	{ key = 't', mods = 'LEADER',       action = act.ShowTabNavigator },
	{ key = 'c', mods = 'LEADER',       action = act.SpawnTab "CurrentPaneDomain" },
	{ key = 'n', mods = 'LEADER',       action = act.ShowLauncher },
	{ key = 'l', mods = 'ALT|SHIFT',    action = act.ActivateTabRelative(1) },
	{ key = 'h', mods = 'ALT|SHIFT',    action = act.ActivateTabRelative(-1) },
	{ key = '&', mods = 'LEADER|SHIFT', action = act.CloseCurrentTab { confirm = true } },
	-- Rename tab
	{
		key = ',',
		mods = 'LEADER',
		action = act.PromptInputLine {
			description = 'Enter new name for tab',
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}
	},

	-- Panes
	{ key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
	{ key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
	{ key = 'h', mods = 'LEADER',       action = act.ActivatePaneDirection('Left') },
	{ key = 'j', mods = 'LEADER',       action = act.ActivatePaneDirection('Down') },
	{ key = 'k', mods = 'LEADER',       action = act.ActivatePaneDirection('Up') },
	{ key = 'l', mods = 'LEADER',       action = act.ActivatePaneDirection('Right') },

	-- Selection mode
	{ key = '[', mods = 'LEADER',       action = act.ActivateCopyMode },
}

-- Apply color formatting
local function fmt(color, text)
	return wezterm.format({ { Foreground = { Color = color } }, { Text = text } })
end

-- Get the current directory
local function basename(s)
	return s:match("([^/]+)/?$")
end

-- BEGIN STATUS BAR
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 32
config.status_update_interval = 1000
-- Workspace name on left side
wezterm.on("update-status", function(window, pane)
	local workspace = window:active_workspace()
	local text = " " .. wezterm.nerdfonts.cod_window .. " " .. workspace .. " "
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = rose_pine.gold } },
		{ Text = text },
	}))
end)
-- Details on right side
wezterm.on("update-status", function(window, pane)
	local username = os.getenv("USER") or os.getenv("LOGNAME") or os.getenv("USERNAME")
	local hostname = wezterm.hostname()
	local date = wezterm.strftime('%a, %H:%M')
	local directory = basename(pane:get_current_working_dir().file_path)

	local text = " " ..
		fmt(rose_pine.iris, username) ..
		fmt(rose_pine.subtle, " " .. wezterm.nerdfonts.fa_user .. " | ") ..
		fmt(rose_pine.text, hostname) ..
		fmt(rose_pine.subtle, " " .. wezterm.nerdfonts.oct_server .. " | ") ..
		fmt(rose_pine.foam, date) ..
		fmt(rose_pine.subtle, " " .. wezterm.nerdfonts.md_calendar_clock .. " | ") ..
		fmt(rose_pine.rose, directory) ..
		fmt(rose_pine.subtle, " " .. wezterm.nerdfonts.fa_folder_o .. " ")

	window:set_right_status(text)
end)
-- Tab names
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
	local tab_title = tab.tab_title
	local tab_index = tab.tab_index + 1
	-- if the tab title is explicitly set, take that
	if tab_title and #tab_title > 0 then
		return " " .. tab_index .. ": " .. tab_title .. " "
	end
	-- Otherwise use title from active pane without .exe
	tab_title = tab.active_pane.title:gsub("%.exe$", "")
	return {
		{ Text = " " .. tab_index .. ": " .. tab_title .. " " },
	}
end)
-- END STATUS BAR

-- Add Visual Studio developer environments to launcher menu
config.launch_menu = {
	{
		label = 'VS2022 Build Tools',
		args = {
			'powershell.exe',
			'-NoExit',
			'-Command',
			'&{Import-Module "C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/Tools/Microsoft.VisualStudio.DevShell.dll"; Enter-VsDevShell 86710beb -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64"}'
		}
	}
}

-- Set default shell
config.default_prog = { "powershell.exe" }

return config
