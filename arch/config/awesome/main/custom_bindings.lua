local awful = require "awful"
local gears = require "gears"
local naughty = require "naughty"
local beautiful = require "beautiful"
local apps = require "main.apps"
local volume = require "ui.popups.volume"
local filesystem = require "gears.filesystem"
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"
local bling = require "lib.bling"

modkey = "Mod4"
alt = "Mod1"

--local function delete_tag()
--	local t = awful.tag.find_by_name(awful.screen.focused(), "")
--	t:delete()
--end
--local function create_tag()
--	awful.tag.add("", {
--				layout = awful.layout.suit.tile,
--				selected = true,
--			})
--end
--local value = false

local screenshot_area = utils_dir .. "screensht area"
local screenshot_full = utils_dir .. "screensht full"

awful.keyboard.append_global_keybindings({
	awful.key({modkey}, "r", function() awful.spawn("rofi -show run -window-format '{c} {t} {n} '") end,
	{ description = "show rofi run", group = "launcher" }),
	awful.key({modkey}, "d", function() bling.module.tabbed.pick() end,
	{ description = "bling tabbed", group = "bling" }),
	awful.key({modkey, "Shift"}, "d", function() bling.module.tabbed.pop() end,
	{ description = "bling untabbed", group = "bling" }),
	awful.key({modkey}, "space", function() awful.spawn("rofi -show drun -window-format '{c} {t} {n} '") end,
	{ description = "show rofi drun", group = "launcher" }),
	awful.key({modkey}, "Print", function()
		awful.spawn.easy_async_with_shell(screenshot_area, function() end) 
	end, { description = "take a area screenshot", group = "Utils" }),
	awful.key({ }, "Print", function()
		awful.spawn("flameshot gui") 
	end, { description = "flameshot", group = "Utils" }),
	awful.key({modkey}, "s", function() 
		
		--if value == false then
		--	create_tag()
		--	value = true
		--else 
		--	delete_tag()
		--	value = false
		--end

		awesome.emit_signal("scratchpad::toggle") end,
	{ description = "show Scratchpad", group = "Utils" }),
	-- awful.key({modkey}, "b", function()
	-- 	awful.spawn.easy_async_with_shell("headsetcontrol -l 0", function() end) 
	-- end, { description = "headsetcontrol", group = "Utils" }),
--	awful.key({modkey}, "r", function() awful.spawn(apps.launcher, false) end), -- Rofi
--	awful.key({alt}, "c", function() awesome.emit_signal("sidebar::toggle") end), -- Sidebar
	awful.key({modkey}, "b", function() awful.spawn(apps.browser) end, 
	{ description = "open browser", group = "launcher" }), -- Toggle titlebar
	awful.key({modkey}, "y", function() awful.spawn(apps.file_manager) end, 
	{ description = "open file manager", group = "launcher" }), -- Toggle titlebar
--	awful.key({alt}, "x", function() awesome.emit_signal("lockscreen::toggle") end), -- Toggle lockscreen
	awful.key({alt}, "Tab", function()
		awesome.emit_signal("bling::window_switcher::turn_on")
	end, {description = "Window Switcher", group = "bling"})
})

-- Volume 
awful.keyboard.append_global_keybindings({
	awful.key({ }, "XF86AudioRaiseVolume", function() 
		volume.increase()
		awesome.emit_signal("widget::update_vol") 
		awesome.emit_signal("module::volume_osd:show", true)
	end),
	awful.key({ }, "XF86AudioLowerVolume", function() 
		volume.decrease()
		awesome.emit_signal("widget::update_vol") 
		awesome.emit_signal("module::volume_osd:show", true)
	end),
	awful.key({ }, "XF86AudioMute", function() volume.mute() awesome.emit_signal("widget::update_vol") awesome.emit_signal("module::volume_osd:show", true) end)
})

-- Brightness
--awful.keyboard.append_global_keybindings({
--	awful.key({ }, "XF86MonBrightnessUp", function() brightness.increase() end),
--	awful.key({ }, "XF86MonBrightnessDown", function() brightness.decrease() end)
--})

