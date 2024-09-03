syntax on
set cursorline
set cursorcolumn
set encoding=utf8
set ts=4
set sts=4
set backspace=indent,eol,start
set nocompatible
set expandtab
set shiftwidth=4
set nu
set hlsearch
set showmatch
set bg=dark
if has("termguicolors")
    set termguicolors
endif


"colorscheme desert

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/ctags.vim'
Plugin 'tell-k/vim-autopep8'
"补全括号
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" 方便注释的
Plugin 'preservim/nerdcommenter'
"python 自动补全
Plugin 'davidhalter/jedi-vim'
call vundle#end()
filetype plugin indent on
filetype plugin on
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"另外一个自动补全
filetype plugin on
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'

"打开
map <F3> :NERDTreeMirror<CR>
"关闭
map <F3> :NERDTreeToggle<CR>
"自动开启Nerdtree
"autocmd vimenter * NERDTree  
let NERDTreeShowBookmarks=1
let g:NERDTreeWinSize = 25
"设定 NERDTree 视窗大小
"开启/关闭nerdtree快捷键
"map <C-f> :NERDTreeToggle<CR>
" 开启Nerdtree时自动显示Bookmarks
"打开vim时如果没有文件自动打开NERDTree
autocmd vimenter * if !argc()|NERDTree|endif
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"设置树的显示图标
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"过滤所有.pyc文件不显示
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.swp'] 
" 是否显示行号
"let g:NERDTreeShowLineNumbers = 1  
"不显示隐藏文件
let g:NERDTreeHidden=0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
"下面是tagbar的配置
let g:tagbar_width = 30
map <F4> :TagbarToggle<CR>
let g:tagbar_autopreview = 1
let g:tagbar_sort = 0

" 运行文件
map <F5> :w<cr>:r!python3 %<cr>
" 跳转
map <F6> :YcmCompleter GoTo<CR>
" 这个跳转的返回是按 ctrl + o
"airline的配置
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 " 显示窗口tab和buffer
let g:airline_theme='murmur'  " murmur配色不错
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'

" auto-pairs's settings
au Filetype FILETYPE let b:AutoPairs = {"(": ")"}
au FileType php      let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php': '?>'})

"autopep8设置"
let g:autopep8_disable_show_diff=1

"NERDCommenter的注释
map <F1> <leader>ci <CR>
"Auto8
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
abbr emb from IPython import embed;embed()
abbr jsr data = json.loads(open(path).read())
abbr glj paths = glob.glob(os.path.join(root, "*.json"))


autocmd BufNewFile *.py,*.sh exec ":call SetPy()"
func SetPy()
    call setline(1, "# ===========================================")
    call append(line("."), "# --coding:UTF-8 --")
    call append(line(".")+1, "# file: ".expand("%:t"))
    call append(line(".")+2, "# author:xxxxxxxxxxxxxxxx")
    call append(line(".")+3, "# date: ".strftime("%Y-%m-%d"))
    call append(line(".")+4, "# ===========================================")
    call append(line(".")+5, "")
    call append(line(".")+6, "import os, sys, glob, click, time, json, pickle")
    call append(line(".")+7, "from loguru import logger")
    call append(line(".")+8, "from tqdm import tqdm")
    call append(line(".")+9, "")
    call append(line(".")+10, "@logger.catch")
    call append(line(".")+11, "@click.command()")
    call append(line(".")+12, "@click.option('--root', default=None, type=str)")
    call append(line(".")+13, "def main(root):")
    call append(line(".")+14, "    logger.info(root)")
    call append(line(".")+15, "")
    call append(line(".")+16, "if __name__ == '__main__':")
    call append(line(".")+17, "    main()")
endfunc

