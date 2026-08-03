#!/usr/bin/env bash
set -euo pipefail

repository_url="https://github.com/zxc-rv/dotfiles"
repository_subdirectory=".config"
target_directory="$HOME/.config"

if ! command -v gum >/dev/null; then
  echo "Нужен gum: sudo pacman -S gum"
  exit 1
fi

temporary_directory=$(mktemp -d)
trap 'rm -rf "$temporary_directory"' EXIT

git clone --filter=blob:none --no-checkout --depth 1 --sparse "$repository_url" "$temporary_directory/repo" &>/dev/null
cd "$temporary_directory/repo"
git sparse-checkout set --no-cone "$repository_subdirectory" &>/dev/null
git checkout &>/dev/null

mapfile -t available_folders < <(find "$repository_subdirectory" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)

if [ ${#available_folders[@]} -eq 0 ]; then
  echo "В $repository_subdirectory пусто"
  exit 1
fi

echo
selected_folders=$(printf '%s\n' "${available_folders[@]}" | gum choose --no-limit --header "Выберите одну или несколько директорий:")

if [ -z "$selected_folders" ]; then
  echo "Ничего не выбрано, выход"
  exit 0
fi

gum style --bold "Выбрано:"
sed 's/^/  • /' <<<"$selected_folders"
echo

if ! gum confirm --default=yes "Переместить в $target_directory?"; then
  echo "Отмена"
  exit 0
fi

mkdir -p "$target_directory"
while IFS= read -r folder_name; do
  echo "ℹ️ Копирую $folder_name..."
  cp -r "$repository_subdirectory/$folder_name" "$target_directory/"
done <<<"$selected_folders"

echo "✅ Готово!"
