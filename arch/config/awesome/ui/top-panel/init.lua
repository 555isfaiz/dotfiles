-- Standard awesome library --
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local widgets = require("ui.top-panel.widgets")
local bling = require("lib.bling")
local helpers = require "helpers"

local beautiful = require("beautiful")

local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local dpi = beautiful.xresources.apply_dpi


local clock = widgets.clock
local date = widgets.date
local cpu = widgets.cpu
local cput = widgets.cputemp
local disk = widgets.disk
local keyboard = widgets.keyboard
local mem = widgets.mem
local menu = widgets.menu
local systray = widgets.systray
local promptbox = widgets.promptbox
local audio = widgets.audio
local seperator = widgets.seperator
local taglist = widgets.taglist
local tasklist = widgets.tasklist
local layoutbox = widgets.layoutbox
local power = widgets.power
local music = widgets.music


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

-- Create Icons with Color --
local calendar_icon = create_icon(' ', beautiful.xcolor5)
local clock_icon = create_icon(' ', beautiful.xcolor12)
local keyboard_icon = create_icon(' ', beautiful.xcolor4)
local window = create_icon(' ', beautiful.xcolor4)
local notifi = create_icon('   ', beautiful.xcolor1)

screen.connect_signal("request::desktop_decoration", function(s)
    -- Create Clock with Colerfull Widget --
    local clockdate = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        calendar_icon,
        date,
        clock_icon,
        clock, -- Middle widget
        forced_width = 250
    }
    
    local tasklist = wibox.widget {
        {
            layout = wibox.layout.fixed.horizontal,
            window,
            s.tasklist, -- needs to be here (under the screen.connect_signal) bc of the s
        },
        layout = wibox.layout.fixed.horizontal,
    }
    
    local notifi_center = wibox.widget {
        {
            layout = wibox.layout.fixed.horizontal,
            notifi,
        },
        layout = wibox.layout.fixed.horizontal,
    }

    notifi_center:add_button(
        awful.button({ }, 1, function()
            awesome.emit_signal("action::toggle")
        end)
    )

    helpers.ui.add_hover_cursor(notifi_center, "hand2")

    local wibar = awful.wibar({

        position = "top",
        screen   = s,
        bg       = "#FFFFFF00",
        height   = 40,
        margins  = { top = 12, left = 12, right = 12 }
    })

    wibar:setup {
        widget = wibox.container.margin,
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            -- layout = wibox.layout.fixed.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                {
                    widget = wibox.container.background,
                    -- bg     = "#1E1E2EEA",
                    bg     = beautiful.xcolorbase.."EA",
                    shape  = helpers.ui.rrect(7),
                    {
                        layout = wibox.layout.fixed.horizontal,
                        menu,
                    },
                },
                {
                    widget = wibox.container.margin,
                    left   = dpi(15),
                    {
                        widget = wibox.container.background,
                        -- bg     = "#1E1E2EEA",
                        bg     = beautiful.xcolorbase.."EA",
                        shape  = helpers.ui.rrect(7),
                        -- forced_width = 50,
                        {
                            layout = wibox.layout.fixed.horizontal,
                            widget = wibox.container.margin,
                            layoutbox,
                        }
                    }
                },
                {
                    widget = wibox.container.margin,
                    left   = dpi(15),
                    {
                        widget = wibox.container.background,
                        -- bg     = "#1E1E2EEA",
                        bg     = beautiful.xcolorbase.."EA",
                        shape  = helpers.ui.rrect(7),
                        {
                            widget = wibox.container.margin,
                            left   = dpi(10),
                            right  = dpi(10),
                            s.taglist
                        }
                    }
                },
                {
                    widget = wibox.container.margin,
                    left   = dpi(15),
                    {
                        widget = wibox.container.background,
                        -- bg     = "#1E1E2EEA",
                        bg     = beautiful.xcolorbase.."EA",
                        shape  = helpers.ui.rrect(7),
                        {
                            widget = wibox.container.margin,
                            left   = dpi(10),
                            right  = dpi(10),
                            tasklist
                        }
                    }
                },
            },
            -- nil,
            { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            {
                widget = wibox.container.margin,
                left   = dpi(15),
                {
                    widget = wibox.container.background,
                    -- bg     = "#1E1E2EEA",
                    bg     = beautiful.xcolorbase.."EA",
                    shape  = helpers.ui.rrect(7),
                    {
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal,
                        left   = dpi(0),
                        right  = dpi(10),
                        clockdate
                    }
                }
            },
            },
            { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            {
                widget = wibox.container.margin,
                left   = dpi(15),
                {
                    widget = wibox.container.background,
                    -- bg     = "#1E1E2EEA",
                    bg     = beautiful.xcolorbase.."EA",
                    shape  = helpers.ui.rrect(7),
                    {
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal,
                        left   = dpi(0),
                        right  = dpi(10),
                        systray,
                    }
                }
            },
            {
                widget = wibox.container.margin,
                left   = dpi(15),
                {
                    widget = wibox.container.background,
                    -- bg     = "#1E1E2EEA",
                    bg     = beautiful.xcolorbase.."EA",
                    shape  = helpers.ui.rrect(7),
                    {
                        layout = wibox.layout.fixed.horizontal,
                        widget = wibox.container.margin,
                        left   = dpi(10),
                        right  = dpi(10),
                        -- music_icon,
                        music
                    }
                }
            },
            {
                widget = wibox.container.margin,
                left   = dpi(15),
                {
                    widget = wibox.container.background,
                    -- bg     = "#1E1E2EEA",
                    bg     = beautiful.xcolorbase.."EA",
                    shape  = helpers.ui.rrect(7),
                    {
                            widget = wibox.container.margin,
                            layout = wibox.layout.fixed.horizontal,
                            left   = dpi(0),
                            right  = dpi(10),
                            audio,
                            cput,
                            mem,
                            cpu,
                            disk,
                            keyboard_icon,
                            keyboard,
                        }
                    }
                },
                {
                    widget = wibox.container.margin,
                    left   = dpi(15),
                    {
                        widget = wibox.container.background,
                        -- bg     = "#1E1E2EEA",
                        bg     = beautiful.xcolorbase.."EA",
                        shape  = helpers.ui.rrect(7),
                        -- forced_width = 50,
                        left   = dpi(10),
                        right  = dpi(10),
                        {
                            layout = wibox.layout.fixed.horizontal,
                            widget = wibox.container.margin,
                            notifi_center,
                        }
                    }
                },
            },
            
        }
    }

    
end)
