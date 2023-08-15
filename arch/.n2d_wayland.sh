#!/bin/bash
pkill -f hyprpaper
pkill -f dunst
pkill -f waybar
cp ~/.config/gtk-4.0/l.css ~/.config/gtk-4.0/gtk.css
cp ~/.config/gtk-4.0/l.ini ~/.config/gtk-4.0/settings.ini
cp ~/.config/gtk-3.0/l.ini ~/.config/gtk-3.0/settings.ini
cp ~/.config/zathura/l ~/.config/zathura/zathurarc
cp ~/.config/alacritty/l.yml ~/.config/alacritty/alacritty.yml
cp ~/.config/BetterDiscord/themes/l.css ~/.config/BetterDiscord/themes/macchiato.theme.css
cp ~/.config/rofi/l.rasi ~/.config/rofi/config.rasi
cp ~/.config/hypr/hyprpaper_d.conf ~/.config/hypr/hyprpaper.conf
cp ~/.config/waybar/latte.css ~/.config/waybar/current.css
cp ~/.config/dunst/d ~/.config/dunst/dunstrc
gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Latte-Standard-Teal-light'
hyprpaper &
dunst &
waybar &
