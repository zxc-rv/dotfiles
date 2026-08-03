#!/bin/bash
export WAYLAND_DISPLAY=wayland-1
export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus

socat - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
  case "$line" in
  "fullscreen>>1") noctalia msg caffeine-enable ;;
  "fullscreen>>0") noctalia msg caffeine-disable ;;
  esac
done
