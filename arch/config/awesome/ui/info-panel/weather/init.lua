local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local filesystem = gears.filesystem
local json = require("lib.json")
local user_vars = require("user_variables")
local icon_dir = filesystem.get_configuration_dir() .. "ui/info-panel/weather/icons/"

--- Weather Widget
--- ~~~~~~~~~~~~~~

local GET_FORECAST_CMD = [[bash -c "curl -s --show-error -X GET '%s'"]]

local icon_map = {
	["01d"] = "weather-clear-sky",
	["02d"] = "weather-few-clouds",
	["03d"] = "weather-clouds",
	["04d"] = "weather-few-clouds",
	["09d"] = "weather-showers-scattered",
	["10d"] = "weather-showers",
	["11d"] = "weather-strom",
	["13d"] = "weather-snow",
	["50d"] = "weather-fog",
	["01n"] = "weather-clear-night",
	["02n"] = "weather-few-clouds-night",
	["03n"] = "weather-clouds-night",
	["04n"] = "weather-clouds-night",
	["09n"] = "weather-showers-scattered",
	["10n"] = "weather-showers",
	["11n"] = "weather-strom",
	["13n"] = "weather-snow",
	["50n"] = "weather-fog",
}

local current_weather_widget = wibox.widget({
	{
		{
			id = "icon",
			image = icon_dir .. "weather-showers.svg",
			resize = true,
			forced_height = dpi(42),
			forced_width = dpi(42),
			widget = wibox.widget.imagebox,
		},
		{
			{
				{
					id = "description",
					text = "Mostly cloudy",
					font = beautiful.font_name .. "Bold 10",
					widget = wibox.widget.textbox,
				},
				{
					id = "humidity",
					text = "Humidity: 80%",
					font = beautiful.font_name .. " 9",
					widget = wibox.widget.textbox,
				},
				layout = wibox.layout.fixed.vertical,
			},
			widget = wibox.container.place,
		},
		spacing = dpi(10),
		layout = wibox.layout.fixed.horizontal,
	},
	nil,
	{
		{
			{
				id = "tempareture_current",
				markup = "20<sup><span>°</span></sup>",
				align = "right",
				font = beautiful.font_name .. "Bold 16",
				widget = wibox.widget.textbox,
			},
			{
				id = "feels_like",
				markup = "Feels like: 19<sup><span>°</span></sup>",
				font = beautiful.font_name .. " 8",
				widget = wibox.widget.textbox,
			},
			spacing = dpi(-6),
			layout = wibox.layout.fixed.vertical,
		},
		widget = wibox.container.place,
	},
	layout = wibox.layout.align.horizontal,
})

local current_weather_widget_2 = wibox.widget({
	{
		{
			{
				id = "city",
				text = "City name",
				font = beautiful.font_name .. "Bold 13",
				widget = wibox.widget.textbox,
			},
			{
				id = "country",
				text = "Country",
				font = beautiful.font_name .. " 10",
				widget = wibox.widget.textbox,
			},
			layout = wibox.layout.fixed.vertical,
		},
		widget = wibox.container.place,
	},
	nil,
	{
		{
			{
				id = "wind_desc",
				markup = " Wind",
				align = "right",
				font = beautiful.font_name .. "Bold 13",
				widget = wibox.widget.textbox,
			},
			{
				id = "wind_cond",
				markup = "wind speed m/s",
				align = "right",
				font = beautiful.font_name .. " 10",
				widget = wibox.widget.textbox,
			},
			spacing = dpi(3),
			layout = wibox.layout.fixed.vertical,
		},
		widget = wibox.container.place,
	},
	layout = wibox.layout.align.horizontal,
})

local hourly_widget = function()
	local widget = wibox.widget({
		{
			{
				id = "time",
				text = "12PM",
				font = beautiful.font_name .. " 9",
				widget = wibox.widget.textbox,
			},
			widget = wibox.container.place,
		},
		{
			{
				id = "icon",
				image = icon_dir .. "weather-clear-sky.svg",
				resize = true,
				forced_height = dpi(16),
				forced_width = dpi(16),
				widget = wibox.widget.imagebox,
			},
			widget = wibox.container.place,
		},
		{
			{
				id = "tempareture",
				markup = "1<sup><span>°</span></sup>",
				font = beautiful.font_name .. " 9",
				widget = wibox.widget.textbox,
			},
			widget = wibox.container.place,
		},
		spacing = dpi(6),
		layout = wibox.layout.fixed.vertical,
	})

	widget.update = function(result)
		local time = widget:get_children_by_id("time")[1]
		local icon = widget:get_children_by_id("icon")[1]
		local temp = widget:get_children_by_id("tempareture")[1]
		temp:set_markup(math.floor(result.temp) .. "<sup><span>°</span></sup>")
		time:set_text(os.date("%I%p", tonumber(result.dt)))
		icon.image = icon_dir .. icon_map[result.weather[1].icon] .. ".svg"
		icon:emit_signal("widget::redraw_needed")
	end
	return widget
end

local hourly_widget_1 = hourly_widget()
local hourly_widget_2 = hourly_widget()
local hourly_widget_3 = hourly_widget()
local hourly_widget_4 = hourly_widget()
local hourly_widget_5 = hourly_widget()
local hourly_widget_6 = hourly_widget()

local weather_widget = wibox.widget({
	{
		text = "Weather",
		font = beautiful.font_name .. "Bold 16",
		align = "center",
		widget = wibox.widget.textbox,
	},
	current_weather_widget_2,
	current_weather_widget,
	{
		-- hourly_widget_1,
		-- hourly_widget_2,
		-- hourly_widget_3,
		-- hourly_widget_4,
		-- hourly_widget_5,
		-- hourly_widget_6,
		spacing = dpi(10),
		layout = wibox.layout.flex.horizontal,
	},
	spacing = dpi(10),
	layout = wibox.layout.fixed.vertical,
})

local api_key = user_vars.widget.weather.key
local coordinates = user_vars.widget.weather.coordinates

local show_hourly_forecast = true
local show_daily_forecast = true
local units = "metric"

local url = (
	"https://api.openweathermap.org/data/2.5/weather"
	.. "?lat="
	.. coordinates[1]
	.. "&lon="
	.. coordinates[2]
	.. "&appid="
	.. api_key
	.. "&units="
	.. units
	.. "&exclude=minutely"
	.. (show_hourly_forecast == false and ",hourly" or "")
	.. (show_daily_forecast == false and ",daily" or "")
)

awful.widget.watch(string.format(GET_FORECAST_CMD, url), 600, function(_, stdout, stderr)
	if stderr == "" then
		local result = json.decode(stdout)
		-- Current weather setup
		local icon = current_weather_widget:get_children_by_id("icon")[1]
		local description = current_weather_widget:get_children_by_id("description")[1]
		local humidity = current_weather_widget:get_children_by_id("humidity")[1]
		local temp_current = current_weather_widget:get_children_by_id("tempareture_current")[1]
		local feels_like = current_weather_widget:get_children_by_id("feels_like")[1]
		local city = current_weather_widget_2:get_children_by_id("city")[1]
		local country = current_weather_widget_2:get_children_by_id("country")[1]
		local wind_cond = current_weather_widget_2:get_children_by_id("wind_cond")[1]
		icon.image = icon_dir .. icon_map[result.weather[1].icon] .. ".svg"
		icon:emit_signal("widget::redraw_needed")
		description:set_text(result.weather[1].description:gsub("^%l", string.upper))
		humidity:set_text("Humidity: " .. result.main.humidity .. "%")
		temp_current:set_markup(math.floor(result.main.temp) .. "<sup><span>°</span></sup>")
		feels_like:set_markup("Feels like: " .. math.floor(result.main.feels_like) .. "<sup><span>°</span></sup>")
		city:set_text(result.name)
		country:set_text(result.sys.country)
		-- wind_cond:set_markup(result.wind.speed .. " m/s" .. result.wind.deg .. "<sup><span>°</span></sup>")
		wind_cond:set_markup(result.wind.speed .. " m/s")
		-- Hourly widget setup
		-- hourly_widget_1.update(result.hourly[1])
		-- hourly_widget_2.update(result.hourly[2])
		-- hourly_widget_3.update(result.hourly[3])
		-- hourly_widget_4.update(result.hourly[4])
		-- hourly_widget_5.update(result.hourly[5])
		-- hourly_widget_6.update(result.hourly[6])
	end
end)

return weather_widget
