command -v Hyprland >/dev/null && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] && exec dbus-run-session Hyprland

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
