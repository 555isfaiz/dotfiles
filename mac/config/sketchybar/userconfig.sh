## These are the default values, you can choose to only include modified options in a clean file

#
### Main config
#

# Set this variable to "on", if you are going to use the dynamic island with macOS's menu bar
P_DYNAMIC_ISLAND_TOPMOST=off

# Which display should the dynamic island be available?
# Available options: All, Primary, Active
P_DYNAMIC_ISLAND_DISPLAY=Primary

P_DYNAMIC_ISLAND_FONT="SF Pro" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
# Enable/Disable Islands
P_DYNAMIC_ISLAND_MUSIC_ENABLED=1
P_DYNAMIC_ISLAND_APPSWITCH_ENABLED=1
P_DYNAMIC_ISLAND_NOTIFICATION_ENABLED=0
P_DYNAMIC_ISLAND_VOLUME_ENABLED=1
# Notch Size
P_DYNAMIC_ISLAND_MAX_HEIGHT=90
P_DYNAMIC_ISLAND_DEFAULT_HEIGHT=65
P_DYNAMIC_ISLAND_DEFAULT_WIDTH=205
P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS=16
# Animation Settings
P_DYNAMIC_ISLAND_SQUISH_AMOUNT=7


#
## App Switch Island config
#
P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_WIDTH=152 # This value should match the notch size, appearence wise
P_DYNAMIC_ISLAND_APPSWITCH_MAX_EXPAND_WIDTH=285 # Max size when expanded
P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_HEIGHT=65
P_DYNAMIC_ISLAND_APPSWITCH_CORNER_RAD=15 # Corner Radius
P_DYNAMIC_ISLAND_APPSWITCH_ICON_SIZE=0.4


#
## Volume Island config
#
P_DYNAMIC_ISLAND_VOLUME_EXPAND_WIDTH=192 # This value should match the notch size, appearence wise
P_DYNAMIC_ISLAND_VOLUME_MAX_EXPAND_WIDTH=250 # Max size when expanded
P_DYNAMIC_ISLAND_VOLUME_DEFAULT_HEIGHT=13
P_DYNAMIC_ISLAND_VOLUME_EXPAND_HEIGHT=16
P_DYNAMIC_ISLAND_VOLUME_CORNER_RAD=12 # Corner Radius
P_DYNAMIC_ISLAND_VOLUME_NORMAL_ICON_COLOR=0xffffffff
P_DYNAMIC_ISLAND_ICON_VOLUME_MAX=􀊩
P_DYNAMIC_ISLAND_ICON_VOLUME_MED=􀊧
P_DYNAMIC_ISLAND_ICON_VOLUME_LOW=􀊥
P_DYNAMIC_ISLAND_ICON_VOLUME_MUTED=􀊡


#
## Music Island config
#
# Music Info
P_DYNAMIC_ISLAND_MUSIC_SOURCE="Music" # AVAILABLE OPTIONS (case sensitive): Music (apple music), Spotify
P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_WIDTH=120 # This value should match the notch size, appearence wise
P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH=270 # Max size when expanded#
P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT=120
P_DYNAMIC_ISLAND_MUSIC_INFO_CORNER_RAD=34 # Corner Radius
# Resume Info
P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_WIDTH=174 # This value should match the notch size, appearence wise
P_DYNAMIC_ISLAND_MUSIC_RESUME_MAX_EXPAND_WIDTH=270
P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT=65
P_DYNAMIC_ISLAND_MUSIC_RESUME_CORNER_RAD=15 # Corner Radius


#
## Notification Island Config
#
P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_WIDTH=93 # This value should match the notch size, appearence wise
P_DYNAMIC_ISLAND_NOTIFICATION_MAX_EXPAND_WIDTH=260 # Max size when expanded
P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_HEIGHT=140
P_DYNAMIC_ISLAND_NOTIFICATION_CORNER_RAD=42 # Corner Radius
P_DYNAMIC_ISLAND_NOTIFICATION_MAX_ALLOWED_BODY=250 # Max allowed body for notification message
