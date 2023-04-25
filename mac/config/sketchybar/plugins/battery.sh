BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep "AC Power")
if [[ $CHARGING != "" ]]; then
  sketchybar -m --set battery          \
    icon=""                          \
    label="AC ${BATT_PERCENT}%"	      \
    icon.padding_left=10
  #exit 0
else
case ${BATT_PERCENT} in
   100) ICON="" ;;
    9[0-9]) ICON="" ;;
    8[0-9]) ICON="" ;;
    7[0-9]) ICON="" ;;
    6[0-9]) ICON="" ;;
    5[0-9]) ICON="" ;;
    4[0-9]) ICON="" ;;
    3[0-9]) ICON="" ;;
    2[0-9]) ICON="" ;;
    1[0-9]) ICON="" ;;
    *) ICON=""
esac
sketchybar -m --set battery            \
  icon="$ICON"                          \
  label="${BATT_PERCENT}%"             \
  icon.padding_left=10
fi