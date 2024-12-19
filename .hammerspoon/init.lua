HYPER = { "cmd", "alt", "ctrl", "shift" }

hs.loadSpoon("AppWindowSwitcher"):setLogLevel("debug"):bindHotkeys({
  ["kitty"] = { HYPER, ";" },
  ["Google Chrome"] = { HYPER, "c" },
})

local micMute = hs.loadSpoon("MicMute")
micMute:bindHotkeys({ toggle = { HYPER, "m" } })

hs.pathwatcher
    .new(os.getenv("HOME") .. "/.hammerspoon/", function()
      hs.reload()
    end)
    :start()

hs.alert.show("Config reloaded")
