#!/usr/bin/env sh

sketchybar --add item        fan.top right                 \
           --set fan.top     label.font="$FONT:Semibold:12"  \
                             icon=" "			    \
	   		     label=fanT                      \
                             icon.drawing=off               \
                             width=0                        \
                             y_offset=6			    \
			     label.padding_right=7          \
			     update_freq=3          \
			     script="$PLUGIN_DIR/fan_top.sh"          \
                                                            \
           --add item        fan.bottom right              \
           --set fan.bottom  label.font="$FONT:Semibold:12"    \
                             label=fanB                      \
                             y_offset=-4                    \
                             width=40                       \
                             icon.drawing=off               \
                             update_freq=3                  \
			     label.padding_right=7          \
			     script="$PLUGIN_DIR/fan_bottom.sh"          \
                                                            \
           --add item        fan.ic right                   \
           --set fan.ic      icon=" "                      \
                   	     label.font="$FONT:Heavy:20"    \
			     label.padding_right=27
