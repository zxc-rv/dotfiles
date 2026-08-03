--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "6", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "7", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "8", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "9", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "10", monitor = "DP-1", persistent = true })
-- hl.workspace_rule({ workspace = "name:G", monitor = "DP-2" })
-- hl.workspace_rule({ workspace = "5", monitor = "DP-2", persistent = true })
--
-- hl.workspace_rule({ workspace = "6", monitor = "DP-1", default = true, persistent = true })
-- hl.workspace_rule({ workspace = "7", monitor = "DP-1", persistent = true })
-- hl.workspace_rule({ workspace = "8", monitor = "DP-1", persistent = true })
-- hl.workspace_rule({ workspace = "9", monitor = "DP-1", persistent = true })
-- hl.workspace_rule({ workspace = "10", monitor = "DP-1", persistent = true })

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.layer_rule({
	match = { namespace = "launcher|vicinae" },
	ignore_alpha = 0.2,
})

hl.layer_rule({
	match = { namespace = "wayle.*" },
	blur = true,
	blur_popups = true,
	ignore_alpha = 0.4,
})

hl.layer_rule({
	match = { namespace = ".*noctalia.*" },
	no_anim = true,
})

hl.layer_rule({
	match = { namespace = ".*noctalia-bar.*" },
	xray = true,
})

hl.layer_rule({
	match = { namespace = "noctalia-screenshot-region" },
	animation = "fade",
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})
hl.window_rule({ match = { class = ".*" }, no_blur = true })
hl.window_rule({ match = { class = "nautilus|XEyes" }, float = true })
hl.window_rule({ match = { class = "org.cachyos.hello" }, float = true })
hl.window_rule({
	match = {
		class = "steam",
		title = "negative:Steam",
	},
	float = true,
})
hl.window_rule({
	match = { title = "Friends List" },
	float = true,
	border_size = 0,
	no_shadow = true,
})
hl.window_rule({
	match = { title = "Media viewer" },
	float = true,
	suppress_event = "fullscreen",
	fullscreen = true,
	border_size = 0,
	rounding = 0,
	no_shadow = true,
	animation = "gnomed 100%",
})
hl.window_rule({
	match = {
		title = "Открытие файлов|Открывается сайт.*|.*запрашивает сохранение",
	},
	float = true,
	no_shadow = true,
	center = true,
})
hl.window_rule({
	match = { title = "Mini App.*" },
	float = true,
	border_size = 0,
	no_shadow = true,
})
hl.window_rule({
	match = { class = "[Xx]dg-desktop-portal-gtk|hyprland-share-picker" },
	float = true,
	no_shadow = true,
	center = true,
	border_size = 0,
})

hl.window_rule({ match = { title = "Vicinae Settings" }, no_blur = false })

hl.window_rule({
	match = { class = "Alacritty|kitty.*|foot.*|otter-term|rio|.*ghostty|.*[Kk]ooha.*" },
	no_blur = false,
	xray = true,
})

hl.window_rule({
	match = { class = "vicinae" },
	no_blur = false,
	stay_focused = true,
})

hl.window_rule({ match = { class = "zen" }, no_blur = false })
hl.window_rule({
	match = { title = "Picture-in-Picture|xeyes" },
	monitor = "DP-1",
	move = { 20, "monitor_h-window_h-50" },
	no_blur = false,
	float = true,
})
hl.window_rule({ match = { class = "org.gnome.Nautilus" }, no_blur = false })
hl.window_rule({ match = { class = "com.gabm.satty|dev.tensaku.Tensaku" }, float = true, center = true })
-- hl.window_rule({ match = { title = "Steam" }, workspace = "2 silent" })

-- hl.window_rule({
-- 	match = { initial_title = "wwm.exe" },
-- 	suppress_event = "fullscreen",
-- 	fullscreen = true,
-- })

-- hl.window_rule({
-- 	match = {
-- 		initial_title = "Там, где начинаются новые приключения|Black Desert Launcher|PALauncher",
-- 	},
-- 	fullscreen = false,
-- 	float = true,
-- 	no_anim = true,
-- 	border_size = 0,
-- 	no_shadow = true,
-- 	content = "none",
-- })

-- hl.window_rule({ match = { title = "Discord|AyuGram" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "mpv" }, float = true, center = true })

hl.window_rule({
	match = {
		class = "org.qbittorrent.qBittorrent",
		title = "negative:qBittorrent.*",
	},
	float = true,
	center = true,
})

-- hl.window_rule({
-- 	match = {
-- 		initial_class = "steam_app_3940563335",
-- 		initial_title = "^$",
-- 	},
-- 	float = true,
-- 	border_size = 0,
-- 	no_shadow = true,
-- 	size = { 20, 20 },
-- 	move = { "monitor_w-window_w-20", 50 },
-- 	rounding = 0,
-- 	monitor = "DP-1",
-- })
-- hl.window_rule({
-- 	match = {
-- 		class = "steam_app_3940563335",
-- 		title = "Black Desert.*",
-- 	},
-- 	fullscreen = true,
-- })

hl.window_rule({ match = { class = "io.github.elyprismlauncher.ElyPrismLauncher" }, float = true, center = true })

hl.window_rule({
	match = { initial_title = "Список друзей" },
	float = true,
})
