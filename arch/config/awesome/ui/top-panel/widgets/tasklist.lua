local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local bling = require "lib.bling"
local wibox = require("wibox")

awful.screen.connect_for_each_screen(function(s)
  local name_section = {
    left   = 10,
    right  = 10,
    widget = wibox.container.margin,
    {
      layout        = wibox.container.scroll.horizontal,
      max_size      = 400,
      speed         = 20,
      step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
      {
        id     = 'text_role',
        widget = wibox.widget.textbox,
        align  = 'center',
        valign = 'center',
      }
    }
  }

  local widget_template = {
    name_section,
    widget = wibox.container.background,
  }
  s.tasklist = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.focused,
    widget_template = widget_template,
    buttons         = {
      --   awful.button({ }, 1, function (c)
      --      c:activate { context = "tasklist", action = "toggle_minimization" }
      --  end),
      awful.button({}, 2, function() awful.menu.client_list { theme = { width = 250 } } end),
      awful.button({}, 3, function() awful.client.focus.byidx(-1) end),
      awful.button({}, 1, function() awful.client.focus.byidx(1) end),
    }
  }

  bling.widget.window_switcher.enable {
    type = "thumbnail", -- set to anything other than "thumbnail" to disable client previews

    -- keybindings (the examples provided are also the default if kept unset)
    hide_window_switcher_key = "Escape", -- The key on which to close the popup
    minimize_key = "n", -- The key on which to minimize the selected client
    unminimize_key = "N", -- The key on which to unminimize all clients
    kill_client_key = "q", -- The key on which to close the selected client
    cycle_key = "Tab", -- The key on which to cycle through all clients
    previous_key = "Left", -- The key on which to select the previous client
    next_key = "Right", -- The key on which to select the next client
    vim_previous_key = "h", -- Alternative key on which to select the previous client
    vim_next_key = "l", -- Alternative key on which to select the next client

    cycleClientsByIdx = awful.client.focus.byidx, -- The function to cycle the clients
    filterClients = awful.widget.tasklist.filter.currenttags, -- The function to filter the viewed clients
  }
end)
