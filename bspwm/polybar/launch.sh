if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload mybar -c ~/.config/bspwm/polybar/config.ini &
  done
else
  polybar --reload mybar -c ~/.config/bspwm/polybar/config.ini &
fi
