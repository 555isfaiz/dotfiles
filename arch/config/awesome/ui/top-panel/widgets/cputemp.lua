local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local helpers = require "helpers"
-- Icon
local icon = wibox.widget.textbox()
icon.font = beautiful.font_name.."16"
icon.align = 'center'
icon.markup = "<span foreground='"..beautiful.xcolor11.."'>  </span>"

-- Uptime
local cput = awful.widget.watch('bash -c "cat /sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input"', 5,
    function(widget, s) widget:set_text((math.floor(tonumber(s)/1000)).. "°C") end)
cput.font = beautiful.font_name.."12"
cput.align = 'center'

local full = wibox.widget {
	{
		{
            icon,
            cput,
            spacing = dpi(2),
            layout = wibox.layout.fixed.horizontal,
		},
		left = 1,
		right = 0,
		layout = wibox.container.margin,
	},
	forced_width = 93, -- Makes it fixed and not Moves Whole Bar 
	layout = wibox.layout.fixed.horizontal,
}


return full


