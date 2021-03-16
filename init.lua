hyper = {"cmd","alt","ctrl"}
shift_hyper = {"cmd","alt","ctrl","shift"}
col = hs.drawing.color.x11
hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall

Install:andUse("TextClipboardHistory",
               {
                 disable = false,
                 config = {
                   show_in_menubar = true,
                 },
                 hotkeys = {
                   toggle_clipboard = { { "cmd",  }, ";" } },
                 start = true,
               }
)

--- quick open applications
function open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

hs.hotkey.bind(shift_hyper, "S", open("Sublime Text"))
hs.hotkey.bind(shift_hyper, "L", open("Slack"))
hs.hotkey.bind(shift_hyper, "F", open("firefox"))
hs.hotkey.bind(shift_hyper, "J", open("Jira"))
hs.hotkey.bind(shift_hyper, "I", open("IntelliJ IDEA Community Release"))
hs.hotkey.bind(shift_hyper, "Z", open("zoom.us"))
hs.hotkey.bind(shift_hyper, "M", open("Spotify"))


--- quick change users in chrome
function chrome_switch_to(ppl)
    return function()
        hs.application.launchOrFocus("Google Chrome")
        local chrome = hs.appfinder.appFromName("Google Chrome")
        local str_menu_item
        if ppl == "Incognito" then
            str_menu_item = {"File", "New Incognito Window"}
        else
            str_menu_item = {"Profiles", ppl}
        end
        local menu_item = chrome:findMenuItem(str_menu_item)
        if (menu_item) then
            chrome:selectMenuItem(str_menu_item)
        end
    end
end

hs.hotkey.bind(shift_hyper, "1", chrome_switch_to("Nikhil"))
hs.hotkey.bind(shift_hyper, "2", chrome_switch_to("Nikhil (Nikhil Ranjan)"))
hs.hotkey.bind(shift_hyper, "3", chrome_switch_to("Incognito"))

--- put laptop on mute if connected to work wifi and using speakers
local workWifi = 'Harness BLR'
local outputDeviceName = 'Built-in Output'
hs.wifi.watcher.new(function()
    local currentWifi = hs.wifi.currentNetwork()
    local currentOutput = hs.audiodevice.current(false)
    if not currentWifi then return end
    if (currentWifi == workWifi and currentOutput.name == outputDeviceName) then
        hs.audiodevice.findDeviceByName(outputDeviceName):setOutputMuted(true)
    end
end):start()

--- automatically reload configuration using reloadconfiguration spoon
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()


---
wifiwatcher = hs.wifi.watcher.new(function ()
    net = hs.wifi.currentNetwork()
    if net==nil then
        hs.notify.show("System lost connection to Wi-Fi","","","")
    else
        hs.notify.show("Connected to Wi-Fi network","",net,"")
    end
end)
wifiwatcher:start()

