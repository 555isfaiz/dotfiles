sketchybar --set fan.bottom label="RPM $(istats | grep "Fan 1" | awk '{print $4 "\t"}')"
