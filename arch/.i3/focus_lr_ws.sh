LEN=$(i3-msg -t get_workspaces | jq length)
CURRENT=$(i3-msg -t get_workspaces | jq '.[]|select(."focused"==true)|."num"')
NEXT=$(($CURRENT+1))
PREV=$(($CURRENT-1))
if [ $NEXT -gt $LEN ]
then
    NEXT=1
fi

if [ $PREV -lt 1 ]
then
    PREV=$LEN
fi

if [ $1 = "left" ]
then
    i3-msg "workspace $PREV; focus child"
else
    i3-msg "workspace $NEXT; focus child"
fi
