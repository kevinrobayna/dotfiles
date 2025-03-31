-- The hyperkey is mapped to caps lock
local hyper = { "cmd", "alt", "ctrl" }

------------------------------- APP LAUNCH/TOGGLE ------------------------------
--[[
  The list of keys and apps which enable launching and toggling
  Some apps have a different process name to their name on disk. To address
  this, a table can be passed which contains the app name followed by the filename
]]
local apps = {
	b = "Arc", -- Browser
	f = "Finder",
	c = "Calendar",
	s = "Slack",
	z = "Zoom.us",
	m = "Mail.app", -- Mail
	o = "Obsidian", -- Life OS
	i = "IntelliJ IDEA Ultimate",
	p = "1Password",
	t = "Alacritty", -- Terminal
}

local LaunchOrToggle = function(key, app_name, app_filename)
	hs.hotkey.bind(hyper, key, function()
		local app = hs.application.find(app_name)
		-- Toggle - show
		local awin = nil
		if app then
			awin = app:mainWindow()
		end
		-- Toggle - hide
		if awin and app and app:isFrontmost() then
			app:hide()
		else
			-- Launch
			if app_filename then
				return hs.application.launchOrFocus(app_filename)
			end

			app = hs.application.find(app_name)

			hs.application.launchOrFocus(app_name)
			app.setFrontmost(app)
			app.activate(app)
		end
	end)
end

for key, app_name in pairs(apps) do
	if type(app_name) == "table" then
		LaunchOrToggle(key, app_name[1], app_name[2])
	else
		LaunchOrToggle(key, app_name)
	end
end
