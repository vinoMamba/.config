## package list

```
eza fastfetch fzf htop lazygit neovim openssh ripgrep starship tree wget zoxide zip unzip 

```

## neovim 

```
git clone https://github.com/vinoMamba/nvim-lua.git
```


## zsh & starship

```
zsh zsh-autosuggestions  zsh-syntax-highlighting 

```

## yazi

```
sudo pacman -S yazi ffmpegthumbnailer p7zip jq poppler fd ripgrep fzf zoxide imagemagick
brew install yazi ffmpegthumbnailer sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font
```

## arch


```
sudo pacman -S iwd starship

```

#### yay

```
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

```


#### fonts

Fira Code Nerd Font

```
wget 

sudo cp -r FiraCode  /usr/share/fonts

sudo fc-cache -f -v

```
Emoji & Chinese

```
# Emoji
yay -S ttf-linux-libertine ttf-inconsolata ttf-joypixels ttf-twemoji-color noto-fonts-emoji ttf-liberation ttf-droid
# Chinese
yay -S wqy-bitmapfont wqy-microhei wqy-microhei-lite wqy-zenhei adobe-source-han-mono-cn-fonts adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts

```
