local awful = require('awful')
local naughty = require('naughty')
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi

local beautiful = require('beautiful')

local clickable_container = require('widget.material.clickable-container')

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/widget/weather/icons/'

-- Weather Updater
require('widget.weather.weather-update')

weather_icon_widget = wibox.widget {
  {
    id = 'icon',
    image = PATH_TO_ICONS .. 'whatever_icon' .. '.svg',
    resize = true,
    forced_height = dpi(45),
    forced_width = dpi(45),
    widget = wibox.widget.imagebox,
  },
  layout = wibox.layout.fixed.horizontal
}

weather_header = wibox.widget {
  text   = "Weather & Temperature",
  font   = 'SFNS Display Regular 14',
  align  = 'center',
  valign = 'center',
  widget = wibox.widget.textbox
}


weather_description = wibox.widget {
  text   = "No internet connection...",
  font   = 'SFNS Display Regular 16',
  align  = 'left',
  valign = 'center',
  widget = wibox.widget.textbox
}

weather_temperature = wibox.widget {
  text   = "Try again later.",
  font   = 'SFNS Display Regular 12',
  align  = 'left',
  valign = 'center',
  widget = wibox.widget.textbox
}

local separator = wibox.widget {
  orientation = 'horizontal',
  forced_height = 1,
  span_ratio = 1.0,
  opacity = 0.90,
  color = beautiful.bg_modal,
  widget = wibox.widget.separator
}

local weather_report =  wibox.widget {
  expand = 'none',
  layout = wibox.layout.fixed.vertical,
  {
    wibox.widget {
      wibox.container.margin(weather_header, dpi(10), dpi(10), dpi(10), dpi(10)),
      border_width = dpi(1),
      border_color = '#ffffff40',
      bg = beautiful.background.hue_900,
      shape = function(cr, width, height)
      gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, 6) end,
      widget = wibox.container.background,
    },
    layout = wibox.layout.fixed.vertical,
  },
  {
    {
      expand = "none",
      layout = wibox.layout.fixed.horizontal,
      {
        wibox.widget {
          weather_icon_widget,
          margins = dpi(4),
          widget = wibox.container.margin
        },
        margins = dpi(5),
        widget = wibox.container.margin
      },
      {
        {

          layout = wibox.layout.fixed.vertical,
          weather_description,
          weather_temperature,
        },
        margins = dpi(4),
        widget = wibox.container.margin
      },
    },
    border_width = dpi(1),
    border_color = '#ffffff40',
    bg = beautiful.background.hue_900,
    shape = function(cr, width, height)
    gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, 6) end,
    widget = wibox.container.background
  },
}

return weather_report
