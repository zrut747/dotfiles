#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc &
run feh --randomize --bg-fill ~/.config/bspwm/wallpapers/ &
run ~/.config/bspwm/polybar/launch.sh &
run picom --config ~/.config/bspwm/picom/picom.conf &
run greenclip daemon>/dev/null &
