import os
import json

sinks = json.loads(os.popen('pactl -f json list').read())
current = os.popen("pactl get-default-sink").read().strip()

current_index = 0
for i in range(len(sinks["sinks"])):
    sink = sinks["sinks"][i]
    if sink["name"] == current:
        current_index = i
        break

next = (current_index + 1) % len(sinks["sinks"])

os.system(f"pactl set-default-sink {sinks['sinks'][next]['index']}")
name = sinks['sinks'][next]['description']
os.system(f'notify-send -t 3000 "Sound Devices" "Changed to {name}"')