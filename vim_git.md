可以将git difftools 与vimdiff联系起来.

```
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool  # 起个别名, git d 
git config --global difftool.trustExitCode true
git config --global mergetool.trustExitCode true


```

或者直接修改 ~/.gitconfig
```
[diff]
    tool = vimdiff
[merge]
    tool
```

然后可以 

git d 文件
可以使用git d –stage 比对working和staged暂存区 使用git d HEAD 比对working和当前版本库的差异。
如果有多个文件有差异， 在vim里退出后，会自动打开下一个差异文件，需要设置信任退出后 :cq!退出全部
如果有长文件修改后， 差异里默认只会显示有修改的上下文位置， 可以把cursor移动到 折叠部位的+的位置再向右移，就会打开被折叠的代码块
也能用z开头的那些快捷键 zr zm za zc zo
:diffupdate :diffu 重计算差异区块
:set noscrollbind  解除滚动绑定
:set scrollbind  两边滚动绑定

如果想查看修改的所有文件的目录 ，git difftool -d


```
# 查看分支1与分支2的代码不同, :qa 可继续下一个code.
git d branch1 branch2
```

```
# 查看当前分支与branch分支 code.py代码的不同
git d branch code.py
```

另外也可配置颜色 写到 ~/.vimrc

```
:help highlight-groups
然后 把想要修改的颜色配置到.vimrc里就行了，例如我配置（抄）的 add 绿 modify黄 delete红
" 新增的行
hi DiffAdd    ctermbg=235  ctermfg=108  guibg=#262626 guifg=#87af87 cterm=reverse gui=reverse
" 变化的行
hi DiffChange ctermbg=235  ctermfg=103  guibg=#262626 guifg=#8787af cterm=reverse gui=reverse
" 删除的行
hi DiffDelete ctermbg=235  ctermfg=131  guibg=#262626 guifg=#af5f5f cterm=reverse gui=reverse
" 变化的文字
hi DiffText   ctermbg=235  ctermfg=208  guibg=#262626 guifg=#ff8700 cterm=reverse gui=reverse
```

而git d 的颜色修改可以使用 （写在init.vim中即可.）

```
" 设置vimdiff时的颜色配置.
set t_Co=256
if ! has("gui_running")
    set t_Co=256
    endif
if &diff
    colors delek
    "colors blue
endif
```
