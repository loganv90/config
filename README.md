# config files

includes config files for:
- alacritty
- tmux
- nvim
- zsh

prerequisites:
- mise
- rg
- fd
- fzf
- tree-sitter-cli

installation:
- download `alacritty.dmg` and `alacritty.info`
- run `ln -s <path_to_repo>/nvim ~/.config/nvim`
- run `ln -s <path_to_repo>/tmux ~/.config/tmux`
- run `ln -s <path_to_repo>/alacritty ~/.config/alacritty`
- add this to main `~/.zshrc`: `source <path_to_repo>/zsh/.zshrc`
- run `tic -xe alacritty,alacritty-direct alacritty.info`
- run `infocmp alacritty` to verify alacritty installation

# apps

## rokit

This is where I should install the following:
- rojo
- luau-lsp
- lune

Updating tools can cause errors like "ERROR No such file or directory (os error 2)" when using the tools.
This can be fixed by deleting the binaries from "~/.rokit/bin", and by re-installing them.

## mise

This is where I should install the following:
- lua-language-server
- node

## alfred

Settings:
- set alfred keybind to cmd+space
- set spotlight keybind to opt+cmd+space

## cursor cli

Settings:
- vim mode: on

