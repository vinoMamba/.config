#!/bin/bash

# 配置项定义
declare -A configs
configs=(
  ["nvim"]="$HOME/oh-my-dotfiles/nvim:$HOME/.config/nvim"
  ["git"]="$HOME/oh-my-dotfiles/git/gitconfig:$HOME/.gitconfig"
  ["skhd"]="$HOME/oh-my-dotfiles/skhd:$HOME/.config/skhd"
  ["starship"]="$HOME/oh-my-dotfiles/starship/starship.toml:$HOME/.config/starship.toml"
  ["zsh"]="$HOME/oh-my-dotfiles/zsh/zshrc-mac:$HOME/.zshrc"
  ["aerospace"]="$HOME/oh-my-dotfiles/aerospace:$HOME/.config/aerospace"
  ["wezterm"]="$HOME/oh-my-dotfiles/wezterm:$HOME/.config/wezterm"
  ["yazi"]="$HOME/oh-my-dotfiles/yazi:$HOME/.config/yazi"
)

backup_dir="$HOME/.config_backup/$(date +%Y%m%d%H%M%S)"

# 设置配置文件链接
setup_config() {
  local name=$1
  local source=${configs[$name]%%:*}
  local target=${configs[$name]#*:}
  local target_dir=$(dirname $target)

  echo "setting up $name config..."

  mkdir -p $target_dir

  if [ -e "$target" ]; then
    mkdir -p "$backup_dir"
    cp -R "$target" "$backup_dir/$(basename $target)"
    echo "Backed up existing $name config to $backup_dir"
  fi

  ln -sf "$source" "$target"
  echo "$name config setup done"
}

# 显示使用方法
show_usage() {
  echo "Usage: $0 [options] [config_name ...]"
  echo "Options:"
  echo "  -h, --help     显示此帮助信息"
  echo "  -l, --list     列出所有可用的配置"
  echo "Available configs:"
  for config in "${!configs[@]}"; do
    echo "  - $config"
  done
}

# 列出所有配置
list_configs() {
  echo "Available configs:"
  for config in "${!configs[@]}"; do
    echo "$config: ${configs[$config]}"
  done
}

# 参数解析
case "$1" in
-h | --help)
  show_usage
  exit 0
  ;;
-l | --list)
  list_configs
  exit 0
  ;;
esac

# 如果没有指定参数，设置所有配置
if [ $# -eq 0 ]; then
  for config in "${!configs[@]}"; do
    setup_config "$config"
  done
else
  # 设置指定的配置
  for config in "$@"; do
    if [ -n "${configs[$config]}" ]; then
      setup_config "$config"
    else
      echo "Error: Unknown config '$config'"
      show_usage
      exit 1
    fi
  done
fi
