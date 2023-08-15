#!/bin/bash
pkill -f hyprpaper
pkill -f dunst
pkill -f waybar
cp ~/.config/gtk-4.0/d.css ~/.config/gtk-4.0/gtk.css
cp ~/.config/gtk-4.0/d.ini ~/.config/gtk-4.0/settings.ini
cp ~/.config/gtk-3.0/d.ini ~/.config/gtk-3.0/settings.ini
cp ~/.config/zathura/d ~/.config/zathura/zathurarc
cp ~/.config/alacritty/m.yml ~/.config/alacritty/alacritty.yml
cp ~/.config/BetterDiscord/themes/m.css ~/.config/BetterDiscord/themes/macchiato.theme.css
cp ~/.config/rofi/m.rasi ~/.config/rofi/config.rasi
cp ~/.config/hypr/hyprpaper_n.conf ~/.config/hypr/hyprpaper.conf
cp ~/.config/dunst/n ~/.config/dunst/dunstrc
cp ~/.config/waybar/macchiato.css ~/.config/waybar/current.css
gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Macchiato-Standard-Teal-dark'
hyprpaper &
dunst &
waybar &
