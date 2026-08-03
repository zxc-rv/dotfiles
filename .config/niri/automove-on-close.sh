#!/usr/bin/env bash

niri msg --json event-stream | while read -r event; do
  if jq -e '.WindowClosed' <<<"$event" >/dev/null 2>&1; then
    niri msg action focus-column-left
    niri msg action focus-column-right
  fi
done
