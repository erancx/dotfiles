HYPER = { "cmd", "alt", "ctrl", "shift" }

hs.loadSpoon("AppWindowSwitcher"):setLogLevel("debug"):bindHotkeys({
	["Ghostty"] = { HYPER, ";" },
	["Google Chrome"] = { HYPER, "c" },
	["Slack"] = { HYPER, "s" },
	["zoom.us"] = { HYPER, "z" },
})

-- Auto-reload configuration when files change
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Helper: Switch to Chrome tab by URL
local function switchToChromeTab(urlPattern)
	local script = string.format(
		[[
		tell application "Google Chrome"
			activate
			repeat with w in windows
				set i to 1
				repeat with t in tabs of w
					if URL of t contains "%s" then
						set active tab index of w to i
						set index of w to 1
						return
					end if
					set i to i + 1
				end repeat
			end repeat
		end tell
	]],
		urlPattern
	)

	hs.osascript.applescript(script)
end

-- Helper: Validate hostname pattern
local function isValidHost(host)
	local envs = { "prod", "dev", "staging" }
	for _, env in ipairs(envs) do
		if host:match("^" .. env .. "%-[a-z0-9]+%-[a-z0-9]+[%.a-z0-9]*$") then
			return true
		end
	end
	return false
end

-- SSH to host from clipboard
hs.hotkey.bind(HYPER, "h", function()
	local host = hs.pasteboard.getContents()
	if not host or host == "" then
		hs.alert.show("Clipboard is empty")
		return
	end

	host = host:gsub("^%s*(.-)%s*$", "%1")
	if not isValidHost(host) then
		hs.alert.show("Invalid hostname format: " .. host)
		return
	end

	hs.application.launchOrFocus("Ghostty")
	hs.timer.doAfter(0.2, function()
		hs.eventtap.keyStroke({ "cmd" }, "t")
		hs.timer.doAfter(0.3, function()
			hs.eventtap.keyStrokes("ussh " .. host)
			hs.eventtap.keyStroke({}, "return")
		end)
	end)
	hs.alert.show("Connecting to " .. host)
end)

-- Switch to WhatsApp Web tab
hs.hotkey.bind(HYPER, "w", function()
	switchToChromeTab("web.whatsapp.com", "WhatsApp")
end)

hs.hotkey.bind(HYPER, "t", function()
	switchToChromeTab("web.telegram.org", "Telegram")
end)

hs.alert.show("Config reloaded")
