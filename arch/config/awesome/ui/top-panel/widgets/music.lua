local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local helpers = require "helpers"

local function create_icon(i, c) --Icon Creation
    local widget = {
        {
            font = beautiful.font_name .. "16",
            text = ' ' .. i,
            widget = wibox.widget.textbox
        },
        fg = c,
        widget = wibox.container.background
    }
    return widget
end

-- Icon
local play_icon = wibox.widget.textbox()
play_icon.font = beautiful.font_name .. "14"
play_icon.align = 'center'
play_icon.markup = "<span foreground='" .. beautiful.xcolor8 .. "'>  </span>"
play_icon:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn.with_shell("playerctl -p $(playerctl -l --ignore-player=chromium | head -n 1) play-pause")
    end)
))

local next_icon = wibox.widget.textbox()
next_icon.font = beautiful.font_name .. "14"
next_icon.align = 'center'
next_icon.markup = "<span foreground='" .. beautiful.xcolor8 .. "'>  </span>"
next_icon:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn.with_shell("playerctl -p $(playerctl -l --ignore-player=chromium | head -n 1) next")
    end)
))

local prev_icon = wibox.widget.textbox()
prev_icon.font = beautiful.font_name .. "14"
prev_icon.align = 'center'
prev_icon.markup = "<span foreground='" .. beautiful.xcolor8 .. "'>  </span>"
prev_icon:add_button(
    awful.button({}, 1, function()
        awful.spawn.with_shell("playerctl -p $(playerctl -l --ignore-player=chromium | head -n 1) previous")
    end)
)

local music_icon = create_icon(' ', beautiful.xcolor13)

helpers.ui.add_hover_cursor(play_icon, "hand2")
helpers.ui.add_hover_cursor(next_icon, "hand2")
helpers.ui.add_hover_cursor(prev_icon, "hand2")

local music_info = wibox.widget.textbox()
music_info.markup = "No player"
music_info.font = beautiful.font_name.."12"
music_info.align = 'center'

local info_section = {
    left   = 10,
    right  = 10,
    widget = wibox.container.margin,
    {
        layout        = wibox.container.scroll.horizontal,
        max_size      = 170,
        speed         = 20,
        step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        {
            widget = music_info,
            align  = 'center',
            valign = 'center',
        }
    }
}

local song = awful.widget.watch('bash -c \'playerctl -p $(playerctl -l --ignore-player=chromium | head -n 1) status\'', 2,
    function(widget, s)
        if string.find(s, "Playing") then
            play_icon:set_markup_silently("<span foreground='" .. beautiful.xcolor8 .. "'>  </span>")
            awful.spawn.easy_async_with_shell('bash -c \'echo "$(playerctl -p $(playerctl -l --ignore-player=chromium | head -n 1) metadata --format "{{ title }} in {{ album }} by {{ artist }}" | grep -m1 in)"\''
                , function(out)
                music_info:set_markup_silently(out)
            end)
        else
            if not string.find(s, "Paused")then
                music_info:set_markup_silently("No player")
            end
            play_icon:set_markup_silently("<span foreground='"..beautiful.xcolor8.."'>  </span>")
        end
    end)
song.font = beautiful.font_name.."12"
song.align = 'center'

local full = wibox.widget {
	{
		{
            music_icon,
            info_section,
            -- music_info,
			song,
            prev_icon,
            play_icon,
            next_icon,
			spacing = dpi(5),
			layout = wibox.layout.fixed.horizontal,
		},
		left = 1,
		right = 0,
		layout = wibox.container.margin,
	},
	-- forced_width = 500,
	layout = wibox.layout.fixed.horizontal,
}

return full

