TEMP=$(istats | grep "CPU temp" | awk '{print $3 "\t"}')
sketchybar --add item cputemp right					\
	   --set cputemp update_freq=3					\
	   		 icon=" "					\
			 script="$PLUGIN_DIR/cputemp.sh"		\
