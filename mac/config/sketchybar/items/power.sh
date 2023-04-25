sketchybar --add item battery right \
           --set battery update_freq=3 \
                         icon.drawing=on \
                         script="~/.config/sketchybar/plugins/power.sh" \
                         background.color=$ITEM_COLOR \
                         background.padding_left=0  \
                         background.height=23        \
                         background.corner_radius=$CORNER_RADIUS
sketchybar --add item power_logo right \
           --set power_logo icon=icon=""  icon.color=$BLACK \
                 icon.font="$FONT:Bold:16.0"  \
                 label.drawing=on \
                 background.color=$GREEN \
                 background.height=23 \
				 background.padding_right=0 \
                 background.corner_radius=$CORNER_RADIUS \
