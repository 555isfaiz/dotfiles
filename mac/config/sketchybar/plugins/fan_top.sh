FAN_SPEED=$(istats | grep "Fan 0" | awk '{gsub(/^[ \t]+|[ \t]+$/, ""); print $4 "\t"}')
sketchybar --set fan.top label="RPM ${FAN_SPEED}"
