# 解决tmux与vim的主题不冲突

问题: 发现开不开tmux的情况下,打开vim时的显示颜色是不一样的.

解决办法: 在开不开tmux时确保 `$TERM` 是相同的即可,并且vim与tmux都可支持.

1. 关闭tmux时的

```
$ echo $TERM
xterm-256color
```

2. 打开tmux 时

```
$ echo $TERM
screen-256color
```

这说明不一致, 方法是把tmux里的更改一下


# method textDocument/definition is not supported by any of the servers registered for the current buffer

neovim有时候跳转的时候会报这个错.

解决方案: 卸载重新安装  python-lsp-server  `python3 -m pip install "python-lsp-server[all]" -U`
最好先更新python的setuptools ` pip install -U setuptools`
