--  rc.lua
--  custom initialisation for awesome windowmanager 4.0.x
--
-- Copyright (C) 2012, 2013 by Togan Muftuoglu <toganm@opensuse.org>
-- Copyright (C) 2015, 2016 by Sorokin Alexei <sor.alexei@meowr.ru>
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License as
-- published by the Free Software Foundation; either version 2, or (at
-- your option) any later version.

-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with GNU Emacs; see the file COPYING.  If not, write to the
-- Free Software Foundation, Inc.,  51 Franklin Street, Fifth Floor,
-- Boston, MA 02110-1301 USA

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local menubar = require("menubar")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Introspection
local lgi = require("lgi")
local gtk = lgi.require("Gtk", "3.0")

-- keybinding
require("keybindings")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors,
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then
      return
    end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err),
    })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- Use personal theme if existing else goto default.
do
  local user_theme, ut
  user_theme = awful.util.getdir("config") .. "/themes/theme.lua"
  ut = io.open(user_theme)
  if ut then
    io.close(ut)
    beautiful.init(user_theme)
  else
    print("Personal theme doesn't exist, falling back to openSUSE")
    beautiful.init(awful.util.get_themes_dir() .. "openSUSE/theme.lua")
  end
end

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or os.getenv("VISUAL") or "vi"
editor_cmd = terminal .. " -e " .. editor

menubar.utils.terminal = terminal
theme.icon_theme = "Adwaita"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
}
-- }}}

require("set-wallpaper")
require("mywibox")

clientkeys = awful.util.table.join(
  awful.key({ modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, "Shift" }, "c", function(c)
    c:kill()
  end, { description = "close", group = "client" }),
  awful.key(
    { modkey, "Control" },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key({ modkey, "Control" }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, { description = "move to master", group = "client" }),
  awful.key({ modkey }, "o", function(c)
    c:move_to_screen()
  end, { description = "move to screen", group = "client" }),
  awful.key({ modkey }, "t", function(c)
    c.ontop = not c.ontop
  end, { description = "toggle keep on top", group = "client" }),
  awful.key({ modkey }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end, { description = "minimize", group = "client" }),
  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- for i = 1, 9 do
-- 	globalkeys = awful.util.table.join(
-- 		globalkeys,
-- 		-- View tag only.
-- 		awful.key({ modkey }, "#" .. i + 9, function()
-- 			local screen = awful.screen.focused()
-- 			local tag = screen.tags[i]
-- 			if tag then
-- 				tag:view_only()
-- 			end
-- 		end, { description = "view tag #" .. i, group = "tag" }),
-- 		-- Toggle tag display.
-- 		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
-- 			local screen = awful.screen.focused()
-- 			local tag = screen.tags[i]
-- 			if tag then
-- 				awful.tag.viewtoggle(tag)
-- 			end
-- 		end, { description = "toggle tag #" .. i, group = "tag" }),
-- 		-- Move client to tag.
-- 		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
-- 			if client.focus then
-- 				local tag = client.focus.screen.tags[i]
-- 				if tag then
-- 					client.focus:move_to_tag(tag)
-- 				end
-- 			end
-- 		end, { description = "move focused client to tag #" .. i, group = "tag" }),
-- 		-- Toggle tag on focused client.
-- 		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
-- 			if client.focus then
-- 				local tag = client.focus.screen.tags[i]
-- 				if tag then
-- 					client.focus:toggle_tag(tag)
-- 				end
-- 			end
-- 		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
-- 	)
-- end

clientbuttons = awful.util.table.join(
  awful.button({}, 1, function(c)
    client.focus = c
    c:raise()
  end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
)

require("rules")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = awful.util.table.join(
    awful.button({}, 1, function()
      client.focus = c
      c:raise()
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      client.focus = c
      c:raise()
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c):setup({
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Middle
      { -- Title
        align = "center",
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  })
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c) then
    client.focus = c
  end
end)

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}
