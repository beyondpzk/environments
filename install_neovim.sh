# for mac and linux
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
python3 -m pip install "python-lsp-server[all]"

# for mac
brew install ctags

# for linux
sudo apt-get install exuberant-ctags

# then open the neovim
exec `PlugInstall`

# 别忘记了在~/.zshrc 里面alias neovim 到 vim 以及 vimdiff
alias vim="nvim"
alias vimdiff="nvim -d"
