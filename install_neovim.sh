# for mac
brew install neovim

# for linux
cd ~/
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz
./nvim-linux64/bin/nvim
# 也可以创建一个soft link
# 也可以通过 alias 将 vim map 到 nvim
# 将 vimdiff map 到 nvim -d

# for mac and linux
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
python3 -m pip install "python-lsp-server[all]"
python3 -m pip install neovim

# for mac
brew install ctags

# for linux
sudo apt-get install exuberant-ctags

# then open the neovim
exec `PlugInstall`

# 别忘记了在~/.zshrc 里面alias neovim 到 vim 以及 vimdiff
alias vim="nvim"
alias vimdiff="nvim -d"
