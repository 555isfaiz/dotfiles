#!/usr/bin/env sh

sketchybar --add item     calendar right                    \
           --set calendar icon=cal                          \
                          icon.font="$FONT:Black:12.0"      \
                          icon.color=$WHITE                 \
                          icon.padding_right=0              \
                          label.width=50                    \
                          label.align=right                 \
                          background.padding_left=3        \
                          update_freq=30                    \
                          script="$PLUGIN_DIR/calendar.sh"  \
#                          click_script="$PLUGIN_DIR/zen.sh"
