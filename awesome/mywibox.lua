local awful = require("awful")
local wibox = require("wibox")

local gears = require("gears")
local vicious = require("vicious")

-- kelu custom widget
local cpuwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.cpu)
vicious.register(cpuwidget, vicious.widgets.cpu, "CPU: <span foreground='#20B2AA'> $1% </span>", 13)

local memwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, "内存: <span foreground='#20B2AA'> $1% </span>", 13)

local batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat, "电量: <span foreground='#20B2AA'> $2% </span>", 61, "BAT0")

local logout_menu_widget = require("widgets.logout-menu-widget.logout-menu")

-- Create a textclock widget
mytextclock = wibox.widget.textclock()
-- calendar2.addCalendarToWidget(mytextclock, "<span color='green'>%s</span>")

-- {{{ Helper functions
local function client_menu_toggle_fn()
  local instance = nil
  return function()
    if instance and instance.wibox.visible then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ theme = { width = 250 } })
    end
  end
end
-- }}}

local tasklist_buttons = awful.util.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following :isvisible()
      -- makes no sense
      c.minimized = false
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
      end
      -- This will also un-minimise the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({}, 3, client_menu_toggle_fn()),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

awful.screen.connect_for_each_screen(function(s)
  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

  -- s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    style = {
      border_width = 1,
      border_color = "#777777",
      shape = gears.shape.rounded_bar,
    },
    layout = {
      spacing = 10,
      spacing_widget = {
        {
          forced_width = 5,
          forced_height = 24,
          thickness = 1,
          color = "#777777",
          widget = wibox.widget.separator,
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      },
      layout = wibox.layout.flex.horizontal,
    },
    widget_template = {
      {
        {
          {
            {
              id = "icon_role",
              widget = wibox.widget.imagebox,
            },
            margins = 2,
            widget = wibox.container.margin,
          },
          {
            id = "text_role",
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left = 10,
        right = 10,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    },
  })

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      logout_menu_widget(),
      cpuwidget,
      memwidget,
      batwidget,
      mytextclock,
    },
  })
end)
