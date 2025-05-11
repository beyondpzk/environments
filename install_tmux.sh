apt install -y tmux 
HOME=$HOME
cd $HOME/
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local $HOME/
echo "set -g default-shell /bin/zsh"  >> "$HOME/.tmux.conf.local"
echo "set -g default-command /bin/zsh"  >> "$HOME/.tmux.conf.local"
echo "set -g default-terminal 'xterm-256color'"  >> "$HOME/.tmux.conf.local"  # 要和vim的保持一致.
echo "set -g mouse on"  >> "$HOME/.tmux.conf.local"  # 要和vim的保持一致.
echo "set clipboard=unnamedplus"  >> "$HOME/.tmux.conf.local"  # 要和vim的保持一致.
tmux source-file $HOME/.tmux.conf.local
