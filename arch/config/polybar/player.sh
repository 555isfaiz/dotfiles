Player=$(playerctl -l --ignore-player=chromium | head -n 1)
Status=$(playerctl -p $Player status)
# Playing=$(playerctl -a status --format "{{playerName}} {{status}}" | grep -m1 "Playing" | awk '{print $1 "\t"}')
# Paused=$(playerctl -a status --format "{{playerName}} {{status}}" | grep -m1 "Paused" | awk '{print $1 "\t"}')
if [ "Playing" = "$Status" ]
then
    polybar-msg action player-info hook 0 &> /dev/null 2>&1
    polybar-msg action player-prev hook 1 &> /dev/null 2>&1
    polybar-msg action player-pause hook 1 &> /dev/null 2>&1
    polybar-msg action player-next hook 1 &> /dev/null 2>&1
elif [ "Paused" = "$Status" ]
then
    polybar-msg action player-info hook 0 &> /dev/null 2>&1
    polybar-msg action player-prev hook 1 &> /dev/null 2>&1
    polybar-msg action player-pause hook 0 &> /dev/null 2>&1
    polybar-msg action player-next hook 1 &> /dev/null 2>&1
else
    polybar-msg action player-info hook 1 &> /dev/null 2>&1
    polybar-msg action player-prev hook 0 &> /dev/null 2>&1
    polybar-msg action player-pause hook 2 &> /dev/null 2>&1
    polybar-msg action player-next hook 0 &> /dev/null 2>&1
fi
# if [ -z "$Playing" ]
# then
#     if [ -z "$Paused" ]
#     then
#         # nothing playing
#         polybar-msg action player-info hook 1 &> /dev/null 2>&1
#         polybar-msg action player-prev hook 0 &> /dev/null 2>&1
#         polybar-msg action player-pause hook 2 &> /dev/null 2>&1
#         polybar-msg action player-next hook 0 &> /dev/null 2>&1
#     else
#         polybar-msg action player-info hook 0 &> /dev/null 2>&1
#         polybar-msg action player-prev hook 1 &> /dev/null 2>&1
#         polybar-msg action player-pause hook 0 &> /dev/null 2>&1
#         polybar-msg action player-next hook 1 &> /dev/null 2>&1
#     fi
# else
#     polybar-msg action player-info hook 0 &> /dev/null 2>&1
#     polybar-msg action player-prev hook 1 &> /dev/null 2>&1
#     polybar-msg action player-pause hook 1 &> /dev/null 2>&1
#     polybar-msg action player-next hook 1 &> /dev/null 2>&1
# fi

# export PB_PLAYING=$Playing
# export PB_PAUSED=$Paused