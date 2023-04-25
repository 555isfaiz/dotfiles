sketchybar --add item theme_listener left \
           --set theme_listener \
            script="$PLUGIN_DIR/theme_listener.sh"\
            updates=on \
           --subscribe theme_listener theme_change
