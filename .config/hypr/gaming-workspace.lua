hl.workspace_rule({ workspace = "name:G", monitor = "DP-2", animation = "fade" })

hl.bind("SUPER + G", hl.dsp.focus({ workspace = "name:G" }))

hl.on("window.open", function(win)
	local isGameWindow = win.class:find("^steam_app_") or win.class == "gamescope"
	if isGameWindow then
		hl.dispatch(hl.dsp.window.move({
			workspace = "name:G",
			window = "address:" .. win.address,
		}))
	end
end)

hl.on("window.close", function(win)
	local ok, err = pcall(function()
		local isGameWindow = win.class:find("^steam_app_") or win.class == "gamescope"
		if not isGameWindow then
			return
		end

		local remainingWindows = 0
		for _, window in pairs(hl.get_windows()) do
			if window.workspace.name == "G" and window.address ~= win.address then
				remainingWindows = remainingWindows + 1
			end
		end

		if remainingWindows == 0 then
			hl.dispatch(hl.dsp.focus({ workspace = "1" }))
		end
	end)
	if not ok then
		hl.notification.create({ text = "error: " .. tostring(err), timeout = 5000 })
	end
end)

hl.window_rule({
	match = { class = "steam_app_.*|gamescope" },
	float = false,
	immediate = true,
	content = "game",
})

hl.window_rule({
	match = {
		initial_class = "steam_app_3940563335",
		initial_title = "negative:^%d+$",
	},
	float = true,
	border_size = 0,
	no_shadow = true,
	no_anim = true,
})
