#!/bin/bash
cp ~/.config/gtk-4.0/l.css ~/.config/gtk-4.0/gtk.css
cp ~/.config/gtk-4.0/l.ini ~/.config/gtk-4.0/settings.ini
cp ~/.config/gtk-3.0/l.ini ~/.config/gtk-3.0/settings.ini
cp ~/.config/zathura/l ~/.config/zathura/zathurarc
cp ~/.config/alacritty/l.yml ~/.config/alacritty/alacritty.yml
cp ~/.config/BetterDiscord/themes/l.css ~/.config/BetterDiscord/themes/macchiato.theme.css
cp ~/.config/rofi/l.rasi ~/.config/rofi/config.rasi
cp ~/.config/xsettingsd/d.conf ~/.config/xsettingsd/xsettingsd.conf
cp ~/.config/awesome/themes/catppuccin/theme.lua_day ~/.config/awesome/themes/catppuccin/theme.lua
cp ~/.wallpaper_day ~/.wallpaper_current
pkill -f xsettingsd; xsettingsd &
echo "awesome.restart()" | awesome-client
