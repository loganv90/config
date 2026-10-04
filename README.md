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
- ln -s pathToRepo/nvim ~/.config/nvim
- ln -s pathToRepo/tmux ~/.config/tmux
- ln -s pathToRepo/alacritty ~/.config/alacritty
- source pathToRepo/zsh/.zshrc

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

## cursor cli

- vim mode: on

