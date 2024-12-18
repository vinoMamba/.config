#!/bin/bash

# 报错时退出
set -e

# 检查 bash 版本并提供明确的升级指导
if ((BASH_VERSINFO[0] < 4)); then
  echo "错误: 当前 Bash 版本过低，需要 Bash 4.0 或更高版本"
  echo "当前 Bash 版本: $BASH_VERSION"
  echo ""
  echo "请按照以下步骤升级 Bash:"
  echo "1. 安装新版本 Bash:    brew install bash"
  echo "2. 添加到可用 shell:   sudo bash -c 'echo /opt/homebrew/bin/bash >> /etc/shells'"
  echo "3. 重新运行此脚本:     /opt/homebrew/bin/bash $0"
  exit 1
fi

# 配置项定义
declare -A configs
configs=(
  ["nvim"]="$HOME/dotfiles/nvim:$HOME/.config/nvim"
  ["git"]="$HOME/dotfiles/git/gitconfig:$HOME/.gitconfig"
  ["yabai"]="$HOME/dotfiles/yabai:$HOME/.config/yabai"
  ["skhd"]="$HOME/dotfiles/skhd:$HOME/.config/skhd"
  ["starship"]="$HOME/dotfiles/starship/starship.toml:$HOME/.config/starship.toml"
  ["zsh"]="$HOME/dotfiles/zsh/zshrc-mac:$HOME/.zshrc"
  ["aerospace"]="$HOME/dotfiles/aerospace:$HOME/.config/aerospace"
  ["wezterm"]="$HOME/dotfiles/wezterm:$HOME/.config/wezterm"
  ["yazi"]="$HOME/dotfiles/yazi:$HOME/.config/yazi"
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
