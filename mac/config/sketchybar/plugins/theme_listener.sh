do_theme_change() {
CURRENT=$(cat "$HOME/.config/sketchybar/plugins/theme_current")

if [[ $CURRENT == "light" ]]
then
  cp "$HOME/.config/sketchybar/plugins/theme_dark" "$HOME/.config/sketchybar/plugins/theme_current"
  cp "$HOME/.config/sketchybar/colors_dark.sh" "$HOME/.config/sketchybar/colors.sh"
else
  cp "$HOME/.config/sketchybar/plugins/theme_light" "$HOME/.config/sketchybar/plugins/theme_current"
  cp "$HOME/.config/sketchybar/colors_light.sh" "$HOME/.config/sketchybar/colors.sh"
fi

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors
HELPER=git.felix.helper
killall helper
cd $HOME/.config/sketchybar/helper && make
$HOME/.config/sketchybar/helper/helper $HELPER > /dev/null 2>&1 &
sketchybar --update
sketchybar --bar     color=$BAR_COLOR                                  \
           --set '/.*/' icon.color=$ICON_COLOR                            \
                     label.color=$LABEL_COLOR                          \
                     icon.highlight_color=$RED                         \
                     popup.background.border_color=$POPUP_BORDER_COLOR \
                     popup.background.color=$POPUP_BACKGROUND_COLOR    \
\
           --set volume script="$PLUGIN_DIR/volume.sh"  \
                        updates=on                      \
                        icon.background.drawing=on      \
                        icon.background.color=$BLUE     \
                        icon.background.height=8        \
                        icon.background.corner_radius=3 \
                        icon.width=0                    \
                        icon.align=right                \
                        label.drawing=off               \
                        background.drawing=on           \
                        background.color=$BACKGROUND_2  \
                        background.height=8             \
                        background.corner_radius=3      \
                        align=left                      \
           --subscribe volume volume_change             \
\
           --set volume_alias icon.drawing=off                           \
                              label.drawing=off                          \
                              alias.color=$TEAL                         \
                              background.padding_right=0                 \
                              background.padding_left=0                  \
                              width=50                                   \
                              align=right                                \
                              click_script="$PLUGIN_DIR/volume_click.sh" \
                     \
           --set apple.logo icon.color=$GREEN \
\
           --set cpu.sys graph.color=$RED               \
                             graph.fill_color=$RED      \
                             background.color=$TRANSPARENT  \
\
           --set cpu.user graph.color=$BLUE \
                          background.color=$TRANSPARENT \
\
           --set cpu.percent mach_helper="$HELPER"\
\
          --set "/space.*/" icon.color=$WHITE              \
                             background.color=$BACKGROUND_1 \
                             label.background.color=$BACKGROUND_2\
\
          --set separator icon.color=$WHITE \
          --set calendar icon.color=$WHITE
}


case "$SENDER" in
  "theme_change") do_theme_change
  ;;
esac
