command -v uwsm >/dev/null && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] && exec uwsm start hyprland-uwsm.desktop

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
