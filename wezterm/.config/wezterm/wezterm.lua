local wezterm = require("wezterm")
local is_dark = true

local function activate_pane(window, pane, pane_direction)
	window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	activate_pane(window, pane, "Right")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	activate_pane(window, pane, "Left")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	activate_pane(window, pane, "Up")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	activate_pane(window, pane, "Down")
end)

local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():set_position(403, 38)
end)

-- wezterm.on("update-right-status", function(window)
--   window:set_right_status(wezterm.format({
--     { Attribute = { Intensity = 'Normal' } },
--     { Text = wezterm.strftime(" %A, %d %B %Y %I:%M %p ") },
--   }))
-- end)

return {
	color_scheme = "Mountain",
	automatically_reload_config = true,
	font = wezterm.font_with_fallback({
		"JetBrainsMono NF",
		"Liga SFMono Nerd Font",
		"Apple Color Emoji",
	}),
	font_size = 11,
	max_fps = 120,
	enable_wayland = false,
	pane_focus_follows_mouse = true,
	warn_about_missing_glyphs = false,
	show_update_window = true,
	check_for_updates = false,
	line_height = 1.5,
	-- window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	audible_bell = "Disabled",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	initial_cols = 106,
	initial_rows = 23,
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = is_dark and 0.85 or 0.95,
	},
	enable_scroll_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = true,
	show_new_tab_button_in_tab_bar = false,
	window_background_opacity = 0.4,
	tab_max_width = 50,
	hide_tab_bar_if_only_one_tab = true,
	disable_default_key_bindings = false,
	keys = {
		{
			mods = "ALT",
			key = [[\]],
			action = wezterm.action({
				SplitHorizontal = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			mods = "ALT|SHIFT",
			key = [[|]],
			action = wezterm.action.SplitPane({
				top_level = true,
				direction = "Right",
				size = { Percent = 50 },
			}),
		},
		{
			mods = "ALT",
			key = [[-]],
			action = wezterm.action({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			mods = "ALT|SHIFT",
			key = [[_]],
			action = wezterm.action.SplitPane({
				top_level = true,
				direction = "Down",
				size = { Percent = 50 },
			}),
		},
		{
			key = "n",
			mods = "ALT",
			action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
		},
		{
			key = "Q",
			mods = "ALT",
			action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
		},
		{
			key = "r",
			mods = "ALT",
			action = wezterm.action.ReloadConfiguration,
		},
		{
			key = "t",
			mods = "SHIFT|ALT",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		},
		{ key = "q", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
		{ key = "z", mods = "ALT", action = wezterm.action.TogglePaneZoomState },
		{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },
		{ key = "h", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },

		{ key = "h", mods = "ALT", action = wezterm.action.EmitEvent("ActivatePaneDirection-left") },
		{ key = "j", mods = "ALT", action = wezterm.action.EmitEvent("ActivatePaneDirection-down") },
		{ key = "k", mods = "ALT", action = wezterm.action.EmitEvent("ActivatePaneDirection-up") },
		{ key = "l", mods = "ALT", action = wezterm.action.EmitEvent("ActivatePaneDirection-right") },

		{ key = "[", mods = "ALT", action = wezterm.action({ ActivateTabRelative = -1 }) },
		{ key = "]", mods = "ALT", action = wezterm.action({ ActivateTabRelative = 1 }) },
		{ key = "{", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(-1) },
		{ key = "}", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(1) },
		{ key = "v", mods = "ALT", action = wezterm.action.ActivateCopyMode },
		{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
		{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
		{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
		{ key = "1", mods = "ALT", action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2", mods = "ALT", action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3", mods = "ALT", action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4", mods = "ALT", action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5", mods = "ALT", action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6", mods = "ALT", action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7", mods = "ALT", action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8", mods = "ALT", action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9", mods = "ALT", action = wezterm.action({ ActivateTab = 8 }) },
	},
	hyperlink_rules = {
		{
			regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b",
			format = "$0",
		},
		{
			regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},
		{
			regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
			format = "mailto:$0",
		},
		{
			regex = [[\bfile://\S*\b]],
			format = "$0",
		},
		{
			regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
			format = "$0",
		},
		{
			regex = [[\b[tT](\d+)\b]],
			format = "https://example.com/tasks/?t=$1",
		},
	},
}
