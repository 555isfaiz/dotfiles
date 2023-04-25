TEMP=$(istats | grep "CPU temp" | awk '{print $3 "\t"}')
TEMPR=$(echo $TEMP)
sketchybar --set cputemp label=$TEMPR
