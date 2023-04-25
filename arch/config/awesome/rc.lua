pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
require("awful.autofocus")
-- Theme --
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/catppuccin/theme.lua")

-- Main/Configuration --
require "main"

-- Libraries/Modules --
require "lib"

-- Signals/Monitoring --
require "signals"

-- Ui/Panels --
require "ui"

-- Autostart --
awful.spawn.with_shell("picom -CGb")
awful.spawn.with_shell("xrandr --output DP-2 --mode 2560x1440 --rate 144.00")
awful.spawn.with_shell("numlockx on")
awful.spawn.with_shell("flameshot &")
awful.spawn.with_shell("fcitx5 -d")
awful.spawn.with_shell("xset s off -dpms")
awful.spawn.with_shell("feh --bg-fill \"$(cat ~/.wallpaper_current)\"")
awful.spawn.with_shell("/usr/bin/lxpolkit")
awful.spawn.with_shell("bash ~/.source_tmux.sh")
-- awful.spawn.with_shell("firefox")
-- awful.spawn.with_shell("start-stop-daemon mpDris2 -q") -- OpenRC mpDris2 since no service file -- 
