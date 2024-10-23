# vim-tex
Plug 'lervag/vimtex'

```
"###### tex 相关配置
let g:vimtex_compiler_method = 'latexmk' 
let g:tex_flavor = 'xelatex'
let g:vimtex_view_method = "skim"
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_general_options = '-r @line @pdf @tex'
"###### tex 相关配置
````

# mac install latexmk 及 basictex

```
sudo brew install basictex --cask
sudo tlmgr update --self --repository http://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet
sudo tlmgr install latexmk --repository http://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet
sudo tlmgr update --self --all
export PATH=/usr/local/texlive/2024basic/bin/universal-darwin:$PATHOA
sudo texhash
sudo mktexls

```

# neovim中使用
\ll 即可完成 compile 并打开 pdf

反向定位,暂时不需要.[TODO]


# error fix

1. `no ctex.sty`
sudo tlmgr install ctex

2. `not found xeCJK...`

sudo tlmgr info XeCJK

3. 总之看什么没有就安什么.


4.  文件开头记得加上 `%! Tex program = xelatex`

5. 如果遇到编译的时候, `! LaTeX Error: File filename xxx.sty not found`

直接运行 `sudo tlmgr install xxx` 即可 直到把所有错误全部解决.
