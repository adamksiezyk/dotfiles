# Dotfiles for environment setup

## Linux .config
Containes config files for Linux.

`.config/env` sets environemnt variables to point to appropriate config files.

### Dependencies
Install:
- node under `/opt/node/`
- nvim under `/opt/nvim/`
- [packer.nvim](https://github.com/wbthomason/packer.nvim) under `~/.local/share/nvim/site/pack/packer/start/packer.nvim`
- tmux
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) under `~/.config/tmux/plugins/tpm`

### Setup

#### NeoVim
```bash
# Install plugins
vim ~/.config/nvim/lua/ksiezyk/packer.lua
:so
:PackerSync
:q

# Install syntax parsers
vim .
:TSUpdate

# Install LSP deps
vim .
:Mason
```

#### tmux
```bash
tmux
tmux source ~/.config/tmux/tmux.conf
```
Press `prefix` + `I` (default prefix is `<C-b>`, my config is set to `<C-Space>`).

## Windows Terminal
I use Windows Terminal to interact with WSL. It supports custom fonts and tabs. Inside WSL I run tmux. For Windows development, see WezTerm below

## WezTerm
For Windows development I can't use tmux. Therefore, I switched from Windows Terminal to WezTerm. It supports workspaces, tabs and panes, similar to tmux.
I configured WezTerm to mimic tmux behavior and shortcuts.

## NeoVim for Windows
Install NeoVim for Windows. Configuration can be found under [.config/nvim/](.config/nvim/). Place it under `%USERPROFILE%\AppData\Local\nvim\`.

For Windows clipboard support, uncomment the code in [.config/nvim/lua/ksiezyk/set.lua](.config/nvim/lua/ksiezyk/set.lua).

To setup, follow [Linux .config/Setup/NeoVim](#neovim).
