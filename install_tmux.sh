cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .


## 但是要注意打开 ~/.tmux.conf.local 把tmux 设置成与自动开启 zsh

#可以将 tmux.conf 中的部分放到 .tmux.conf.local 中
#set -g default-shell /bin/zsh
#set -g default-command /bin/zsh
#set -g default-terminal "xterm-256color"  # 与退出tmux执行 `echo $TERM` 保持一致.
