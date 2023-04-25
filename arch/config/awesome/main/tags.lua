local awful = require "awful"

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag({" ", "爵 ", " ", " ", " ", " ", "輸 ", " ", " "}, s, awful.layout.layouts[1])
end)
