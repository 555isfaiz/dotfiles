local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local helpers = require "helpers"
local json    = require("lib.json")

-- Icon
local icon = wibox.widget.textbox()
icon.font = beautiful.font_name.."16"
icon.align = 'center'
icon.markup = "<span foreground='"..beautiful.xcolor2.."'>  </span>"

-- Uptime
local pulseaudio = wibox.widget.textbox()
pulseaudio.font = beautiful.font_name.."12"
pulseaudio.align = 'center'


local function get_val()
	awesome.connect_signal("signal::volume", function(vol, muted)
		if muted then pulseaudio.markup = "0%" icon.markup = "<span foreground='"..beautiful.xcolor2.."'>  </span>" else
			pulseaudio.markup = tonumber(vol).. "%" 
			icon.markup = "<span foreground='"..beautiful.xcolor2.."'>  </span>"
		end
	end)
end

get_val()

local full = wibox.widget {
	{
		{
	icon,
	pulseaudio,
	spacing = dpi(8),
	layout = wibox.layout.fixed.horizontal,
		},
	left = dpi(5),
    -- right = 8,
    layout = wibox.container.margin,
	},
	forced_width = 90, --66,
	layout = wibox.layout.fixed.horizontal,
}

local audio_menu = awful.menu {
  theme = {
    font = beautiful.font_name .. "12",
    width = 400
  },
  -- items = {{" hello"}, {"world"}}
}

local slider = wibox.widget {
    bar_shape = helpers.ui.rrect(9),
    bar_height = 6,
    bar_color = beautiful.xcolorbase,
    bar_active_color = beautiful.xcolor2,
    handle_shape = gears.shape.circle,
    handle_color = beautiful.xcolor2,
    handle_width = 12,
    value = 75,
    forced_width = dpi(239),
    widget = wibox.widget.slider,
}

slider:buttons(gears.table.join(
    awful.button({}, 4, nil, function()
        if slider:get_value() > 100 then
            slider:set_value(100)
            return
        end
        slider:set_value(slider:get_value() + 5)
    end),
    awful.button({}, 5, nil, function()
        if slider:get_value() < 0 then
            slider:set_value(0)
            return
        end
        slider:set_value(slider:get_value() - 5)
    end)
))

local update_volume = function() -- Sets the Volume Correct
    awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
        slider.value = tonumber(stdout:match("%d+"))
    end)
end

awesome.connect_signal("widget::update_vol", function()
    update_volume()
end)

awesome.connect_signal("widget::update_vol_slider", function(volume_level)
    slider:set_value(volume_level)
end)

helpers.ui.add_hover_cursor(slider, "hand1")

local slider_container = wibox {
	visible = false,
	ontop = true,
	width = 270,
	height = 30,
	x = dpi(1900),
	y = dpi(50),
	bg = beautiful.bg_normal,
	border_width = dpi(3),
	border_color = beautiful.xcolorS0,
}

slider_container : setup {
	{
		slider,
		spacing = dpi(20),
		layout = wibox.layout.fixed.vertical,
	},
	margins = { top = dpi(5), bottom = dpi(5), left = dpi(10), right = dpi(10)},
	widget = wibox.container.margin,
}

slider_container.shape = function(cr,w,h)	--Rounded Corners
	gears.shape.rounded_rect(cr,w,h,14)
end

full:buttons(gears.table.join(
	awful.button({}, 1, function()
		local script = [[
		pamixer -t
		]]

		awful.spawn(script, false)
		awesome.emit_signal("widget::update_vol")
	end),
	awful.button({}, 2, function()
		local all_script = "pactl -f json list"
		local current_script = 'pactl get-default-sink'
		local len = 0
		for i = 1, #audio_menu.items, 1 do
			audio_menu:delete(1)
		end
		awful.spawn.easy_async_with_shell(current_script, function(out)
			awful.spawn.easy_async_with_shell(all_script, function(o)
				local all_res = json.decode(o)
				for index, value in ipairs(all_res.sinks) do
					if string.find(tostring(out), tostring(value.name), 0, true) ~= nil then
						audio_menu:add({
							" " .. value.description,
						})
					else
						audio_menu:add({
							value.description,
							function()
								awful.spawn.with_shell("pactl set-default-sink " .. value.index)
								awesome.emit_signal("widget::update_vol")
							end
						})
					end
				end
				audio_menu:show()
			end)
		end)
	end),
	awful.button({}, 3, function()
		slider_container.visible = not slider_container.visible
	end)
))

helpers.click2hide.menu(audio_menu, nil, true)

-- Update Function
local update_volume = function()  -- Sets the Volume Correct
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout) 
		pulseaudio.markup = tonumber(stdout:match("%d+")).. "%"
	
	-- Uncomment this if you wan't dynamic Icons --
	--	if tonumber(stdout:match("%d+")) < 10 then
	--		icon.markup = "<span foreground='"..beautiful.xcolor2.."'>奄</span>"
	--	elseif tonumber(stdout:match("%d+")) < 50  then
	--		icon.markup = "<span foreground='"..beautiful.xcolor2.."'>奔</span>"
	--	elseif tonumber(stdout:match("%d+")) < 100 then
	--		icon.markup = "<span foreground='"..beautiful.xcolor2.."'>墳</span>"
	--	else
	--	end
			

	end)
end

update_volume()
awesome.connect_signal("widget::update_vol", function()
	update_volume()
end)
awesome.connect_signal("widget::update_vol_pulse", function()
	update_volume()
end)
-- helpers.ui.add_hover_cursor(full, "hand2")

slider:connect_signal("property::value", function(_, new_value)
    awful.spawn("pamixer --set-volume " .. new_value, false)
    local volume_level = slider:get_value()
    awesome.emit_signal("widget::update_vol_pulse") -- update_vol_pulse doesn't Update Volume Signal
    awesome.emit_signal("widget::update_vol_slider", volume_level) -- update_vol_pulse doesn't Update Volume Signal
end)

awesome.connect_signal("widget::update_vol_slider", function(volume_level)
    slider:set_value(volume_level)
end)

return full

