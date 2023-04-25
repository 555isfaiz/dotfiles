#!/bin/bash
cp ~/.config/gtk-4.0/d.css ~/.config/gtk-4.0/gtk.css
cp ~/.config/gtk-4.0/d.ini ~/.config/gtk-4.0/settings.ini
cp ~/.config/gtk-3.0/d.ini ~/.config/gtk-3.0/settings.ini
cp ~/.config/zathura/d ~/.config/zathura/zathurarc
cp ~/.config/alacritty/m.yml ~/.config/alacritty/alacritty.yml
cp ~/.config/BetterDiscord/themes/m.css ~/.config/BetterDiscord/themes/macchiato.theme.css
cp ~/.config/rofi/m.rasi ~/.config/rofi/config.rasi
cp ~/.config/xsettingsd/n.conf ~/.config/xsettingsd/xsettingsd.conf
cp ~/.config/awesome/themes/catppuccin/theme.lua_night ~/.config/awesome/themes/catppuccin/theme.lua
cp ~/.wallpaper_night ~/.wallpaper_current
pkill -f xsettingsd; xsettingsd &
echo "awesome.restart()" | awesome-client
