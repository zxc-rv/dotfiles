require("monitors")
require("autostart")
require("keymaps")
require("env")
require("decorations")
require("animations")
require("input")
require("rules")
require("gaming-workspace")
require("noctalia").apply_theme()

hl.config({
	dwindle = {
		preserve_split = false, -- You probably want this
	},
	master = {
		new_status = "slave",
		mfact = 0.5,
	},
	scrolling = {
		fullscreen_on_one_column = true,
		column_width = 0.5,
		focus_fit_method = 1,
		follow_focus = true,
		follow_min_visible = 1,
		wrap_focus = false,
		wrap_swapcol = false,
	},
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
		focus_on_activate = false,
		vrr = 3,
	},
	render = {
		direct_scanout = 2,
	},
	quirks = { skip_non_kms_dmabuf_formats = true },
})
