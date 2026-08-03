#!/usr/bin/env bash
gameWorkspaceName="G"

niri msg --json event-stream | while IFS= read -r eventLine; do
  eventType=$(jq -r 'keys[0]' <<<"$eventLine")

  if [[ "$eventType" == "WindowOpenedOrChanged" ]]; then
    appId=$(jq -r '.WindowOpenedOrChanged.window.app_id // empty' <<<"$eventLine")
    windowId=$(jq -r '.WindowOpenedOrChanged.window.id' <<<"$eventLine")

    if [[ "$appId" =~ ^steam_app_ || "$appId" == "gamescope" ]]; then
      focusedOutput=$(niri msg -j focused-output | jq -r '.name')
      emptyWorkspaceIndex=$(niri msg -j workspaces | jq --arg output "$focusedOutput" \
        '[.[] | select(.output == $output)] | max_by(.idx) | .idx')

      niri msg action set-workspace-name "$gameWorkspaceName" --workspace "$emptyWorkspaceIndex"
      niri msg action move-window-to-workspace "$gameWorkspaceName" --window-id "$windowId"
    fi
  fi

  if [[ "$eventType" == "WindowClosed" ]]; then
    gameWorkspaceId=$(niri msg -j workspaces | jq -r --arg name "$gameWorkspaceName" '.[] | select(.name == $name) | .id')

    if [[ -n "$gameWorkspaceId" ]]; then
      remainingWindows=$(niri msg -j windows | jq --argjson id "$gameWorkspaceId" '[.[] | select(.workspace_id == $id)] | length')

      if [[ "$remainingWindows" -eq 0 ]]; then
        niri msg action unset-workspace-name "$gameWorkspaceName"
        niri msg action focus-workspace 1
      fi
    fi
  fi
done
