# config files

includes config files for:
- alacritty
- tmux
- nvim

prerequisites:
- nvm
- ripgrep
- go dlv
- debugpy

installation:
- ln -s pathToRepo/nvim ~/.config/nvim
- ln -s pathToRepo/tmux ~/.config/tmux
- ln -s pathToRepo/alacritty ~/.config/alacritty
- :Copilot setup
- make a debugpy virtualenv in ~/.virtualenvs/
