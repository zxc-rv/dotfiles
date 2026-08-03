hl.config({
	general = {
		allow_tearing = true,
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		col = {
			active_border = { colors = { "rgb(00d5ff)", "rgb(004cff)" }, angle = 45 },
			-- active_border = "rgb(707070)",
			-- inactive_border = "rgba(595959aa)",
		},
		resize_on_border = false,
		layout = "scrolling",
	},
	-- plugin = {
	-- 	split_monitor_workspaces = {
	-- 		count = 5,
	-- 		keep_focused = 1,
	-- 		enable_notifications = 0,
	-- 		enable_persistent_workspaces = 1,
	-- 		enable_wrapping = 1,
	-- 		link_monitors = 0,
	-- 		-- enable_hy3                = 1,
	-- 	},
	-- },

	decoration = {
		rounding = 0,
		rounding_power = 1,
		-- active_opacity = 1.0,
		-- inactive_opacity = 0.9,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 2,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 4,
			passes = 3,
			noise = 0.01,
			contrast = 1.4,
			brightness = 1.2,
			vibrancy = 0.1696,
		},
	},
})
