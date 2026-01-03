command -v start-hyprland >/dev/null && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] && exec start-hyprland 

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
