# Dotfiles

This repository contains my dotfiles.

## Requirements
tmux
vim
zsh


## Installation

```bash
git clone
cd dotfiles
./bootstrap.sh
```

## Remove

```bash
./remove.sh
```

## Extras

Setup zsh-autosuggestions

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
```
sudo vi ~/.zshrc
```
```
plugins=(
  # other plugins...
  zsh-autosuggestions
)
```
```
plugins=(
  # other plugins...
  zsh-autosuggestions
)
```
```
source ~/.zshrc
```
