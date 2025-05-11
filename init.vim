syntax on
set cursorline
set encoding=utf-8
set ts=4 
set sts=4 
set expandtab
autocmd FileType python set expandtab | set tabstop=4
set shiftwidth=4
set history=10000
set nu
set hlsearch
set showmatch
set bg=dark

" 设置搜索时不区分大小写
set ignorecase
set smartcase
" 设置 自动换行
set wrap
set textwidth=160 "设置自动换行的长度为 80 个字符，
set linebreak
" 设置自动缩进
filetype plugin indent on
" 设置鼠标支持
set mouse=a
hi Cursor guifg=#FF00FF guibg=none  " 设置为紫红色

" 安装插件管理工具 vim-plug 的配置示例
call plug#begin('~/.vim/plugged')
Plug 'windwp/nvim-autopairs'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-path'
"这个与下面的cmp_nvim_lsp的配置对应着,要一起使用.
"Plug 'hrsh7th/cmp-nvim-lsp'    
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'preservim/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin' 暂时用不到.
Plug 'scrooloose/nerdcommenter'
"Plug 'nvim-tree/nvim-tree.lua' 与nerdtree重复.
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
"Plug 'morhetz/gruvbox'

"vim-fugitive与vim-airline 一起使用可以显示当前代码的git所在状态.
Plug 'tpope/vim-fugitive'   
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"tagbar主要是看代码结构的.
Plug 'majutsushi/tagbar'
" 需要安: sudo apt-get install exuberant-ctags
" 下面的两个是neovim-remote的相关.类似于配置IDE
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
"下面这个是补全函数参数的
"Plug 'ray-x/lsp_signature.nvim' # 与上面hrsh7th/nvim_lsp_signature_help 类似.
" Using Vim-Plug:
Plug 'Mofiqul/dracula.nvim'
" 看缩进线的
Plug 'Yggdroot/indentLine'
" git 相关
Plug 'f-person/git-blame.nvim'
call plug#end()

" Vim-Script:
lua << EOF
local dracula = require("dracula")
dracula.setup({
  -- customize dracula color palette
  -- 深灰色：#808080
  -- 灰色：#C0C0C0
  -- 浅灰色：#D3D3D3
  colors = {
    bg = "#282A36",
    -- fg = "#808080",
    fg = "#C0C0C0",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    orange = "#FFB86C",
    yellow = "#F1FA8C",
    green = "#50fa7b",
    purple = "#BD93F9",
    cyan = "#8BE9FD",
    pink = "#FF79C6",
    bright_red = "#FF6E6E",
    bright_green = "#69FF94",
    bright_yellow = "#FFFFA5",
    bright_blue = "#D6ACFF",
    bright_magenta = "#FF92DF",
    bright_cyan = "#A4FFFF",
    bright_white = "#FFFFFF",
    menu = "#21222C",
    visual = "#3E4452",
    gutter_fg = "#4B5263",
    nontext = "#3B4048",
    white = "#ABB2BF",
    black = "#191A21",
  },
  -- show the '~' characters after the end of buffers
  show_end_of_buffer = true, -- default false
  -- use transparent background
  transparent_bg = true, -- default false
  -- set custom lualine background color
  lualine_bg_color = "#44475a", -- default nil
  -- set italic comment
  italic_comment = true, -- default false
  -- overrides the default highlights with table see `:h synIDattr`
  overrides = {},
  -- You can use overrides as table like this
  -- overrides = {
  --   NonText = { fg = "white" }, -- set NonText fg to white
  --   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
  --   Nothing = {} -- clear highlight of Nothing
  -- },
  -- Or you can also use it like a function to get color from theme
  -- overrides = function (colors)
  --   return {
  --     NonText = { fg = colors.white }, -- set NonText fg to white of theme
  --   }
  -- end,
})
EOF
colorscheme dracula
"颜色设置参考下面,本来fg是白色,我把它设成了紫色了
"https://github.com/Mofiqul/dracula.nvim

" 加载插件
if filereadable(expand('~/.vim/plugged/plugin/installed.vim'))
  source ~/.vim/plugged/plugin/installed.vim
endif



" NERDTree 配置
"默认不打开
let g:NERDTreeAutoOpen = 0
"可以通过F4来打开
map <F4> :NERDTreeToggle<CR>:wincmd l<CR>

"参考 https://github.com/hrsh7th/nvim-cmp
"自动补全
lua << EOF
local cmp = require('cmp')

cmp.setup({
    snippet = {
     expand = function(args)
       vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
     end,
    },
    sources = cmp.config.sources({
     { name = 'nvim_lsp' },
     { name = 'buffer' },
     { name = 'path' },  
     { name = 'nvim_lsp_signature_help'},
     { name = 'vsnip' }
    }),
    mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    },
})


-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
}),
matching = { disallow_symbol_nonprefix_matching = false }
})

EOF


nnoremap <F8> :lua vim.lsp.buf.code_action()<CR>


"lua << EOF
"-- 可以直接用pylsp的默认能力.但是不太好用.示例如下.用这个的话需要把下面pylsp的设置给注释掉
"local capabilities = require('cmp_nvim_lsp').default_capabilities()
"require('lspconfig').pylsp.setup {
"capabilities = capabilities
"}
"EOF



"lua << EOF
"local lspconfig = require('lspconfig')
"-- 创建自动命令组
"vim.api.nvim_create_autocmd("FileType", {
    "pattern = "python",
    "callback = function()
        "lspconfig.pylsp.setup{}
    "end
"})
"EOF

"lua << EOF
"lspconfig = require("lspconfig")
"lspconfig.pylsp.setup {
    "settings = {
        "pylsp = {
        "plugins = {
            "black = { enabled = false },
            "autopep8 = { enabled = false },
            "yapf = { enabled = false },
            "pylint = { enabled = false, executable = "pylint" },
            "pyflakes = { enabled = false },
            "pycodestyle = { enabled = false },
            "pylsp_mypy = { enabled = false },
            "jedi_completion = { fuzzy = false },
            "pyls_isort = { enabled = false },
            "isort = {enabled = false},
        "},
        "},
    "},
    "flags = {
        "debounce_text_changes = 200,
    "},
"}
"EOF


"在mac上可以用texlab
"lua << EOF
"local lspconfig = require('lspconfig')
"lspconfig.texlab.setup{}
"EOF


lua << EOF
local autopairs = require('nvim-autopairs')
autopairs.setup({
enable_check_bracket_line = true, -- 可根据需要调整此选项
})
EOF

let g:autopairs_enabled = 1
let g:autopairs_autoclose = 1

map <F1> <leader>ci <CR>

let g:languageserver_python = {'server': 'pylsp',}

" 设置快捷键 F6 列出引用并跳转到引用处, 引用有一些慢,还是定义比较快一些.
" nnoremap <F9> :lua vim.lsp.buf.references()<CR>
nnoremap <F6> :lua vim.lsp.buf.definition()<CR>

" 设置快捷键 F8 触发 autopep8 格式化（假设使用 autopep8）
nnoremap <F8> :silent!!autopep8 --in-place %<CR>:e<CR>
" 或者设置快捷键触发 black 格式化（假设使用 black）
"nnoremap <F8> :silent!!black %<CR>:e<CR>
"也可以用ruff
"nnoremap <F8> :silent!!ruff check --fix && ruff format %<CR>:e<CR>
"function! FixPythonFile()
   "let current_file = expand('%')
   "execute "silent!term ruff format ". current_file
"endfunction

" 代码折叠相关配置,不过感觉不太好用
" 设置开启折叠
"set foldenable
" 设置折叠方法为缩进折叠
"set foldmethod=indent
" 设置快捷键 zc 折叠代码
" nnoremap <silent> zc :foldclose<CR>
" 设置快捷键 zo 展开代码
" nnoremap <silent> zo :foldopen<CR>
" 设置快捷键 za 切换代码折叠状态
" nnoremap <silent> za :if foldclosed(line('.')) == -1 | exe 'normal! zc' | else | exe 'normal! zo' | endif<CR>
"

"autocmd vimenter * nested colorscheme gruvbox
"let g:gruvbox_contrast_dark = 'medium'
:abbr emb from IPython import embed;embed()
:abbr plp pickle.load(open(path, "rb"))
:abbr jlp json.loads(open(path, "r").read())
autocmd BufNewFile *.py exec ":call SetPy()"
func SetPy()
    call setline(1, "# ===========================================")
    call append(line("."), "# -*- coding: utf-8 -*-")
    call append(line(".")+1, "# file: ".expand("%:t"))
    call append(line(".")+2, "# author: xxx")
    call append(line(".")+3, "# date: ".strftime("%Y-%m-%d"))
    call append(line(".")+4, "# ===========================================")
    call append(line(".")+5, "")
    call append(line(".")+6, "import os, sys, glob, click, pickle, json")
    call append(line(".")+7, "import numpy as np")
    call append(line(".")+8, "from loguru import logger")
    call append(line(".")+9, "from tqdm import tqdm")
    call append(line(".")+10, "")
    call append(line(".")+11, "@logger.catch")
    call append(line(".")+12, "@click.command()")
    call append(line(".")+13, "@click.option('--root', type=str, default=None)")
    call append(line(".")+14, "def main(root):")
    call append(line(".")+15, "    logger.info(root)")
    call append(line(".")+16, "")
    call append(line(".")+17, "")
    call append(line(".")+18, "    return")
    call append(line(".")+19, "")
    call append(line(".")+20, "")
    call append(line(".")+21, "if __name__ == '__main__':")
    call append(line(".")+22, "    main()")
endfunc

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
let g:airline_section_z = '%{strftime("%c")}'



"下面是tagbar的配置
let g:tagbar_width = 30
" 左边打开
" map <F4> :TagbarToggle<CR>:wincmd l<CR>
map <F7> :TagbarToggle<CR>:wincmd r<CR>
let g:tagbar_autopreview = 1
let g:tagbar_sort = 1


" 配置IDE
nnoremap <silent><F5> :call RunPythonFile()<CR>
function! RunPythonFile()
   let current_file = expand('%')
   " execute "vnew | set bt=nofile | silent!term python ". current_file
   execute "new | set bt=nofile | silent!term python ". current_file
   wincmd k
   resize 20
endfunction


nnoremap <silent><F3> :call ExecuteCommandAndShowOutput()<CR>
function! ExecuteCommandAndShowOutput()
   let command = input("Enter command: ")
   execute "new | set bt=nofile | silent!term ".command
   wincmd k
   resize 10
endfunction


" 之前按Ctrl-w比较费劲,可以用F2来代替, 别忘记了按完F2后还要按上下键.
nnoremap <F2> <C-w>

" . 在vim里面是连接符

autocmd BufNewFile *.md exec ":call SetMd()"
func SetMd()
    let filename = expand("%:t")
    if strpart(filename, 0, 2) == "20"
        let parts = split(filename, "-")
        let name = parts[3]
        let title = split(name, "\.md")
        call setline(1, "---")
        call append(line("."), "layout: post")
        call append(line(".")+1, "title: " . title[0])
        call append(line(".")+2, "date: " . parts[0] . "-" . parts[1] . "-" . parts[2])
        call append(line(".")+3, "categories: [reading]")
        call append(line(".")+4, "tags: reading")
        call append(line(".")+5, "---")
        call append(line(".")+6, "<!--more-->")
        call append(line(".")+7, "")
        call append(line(".")+8, "")
        call append(line(".")+9, "- [paper地址]()")
        call append(line(".")+10, "")
        call append(line(".")+11, "#")
        call append(line(".")+12, "")
        call append(line(".")+13, "## sketch the main points")
    else
        return 0
    endif
endfun

"开启或关闭缩进线：
let g:indentLine_enabled = 0
"设置缩进线的颜色：
let g:indentLine_char = '┊'
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#aaaaaa'
"设置缩进线的样式：
let g:indentLine_conceal_underline = 0


"下面是 ruff的配置,一个更快的python工具
"lua << EOF
"require('lspconfig').ruff.setup {
  "init_options = {
    "settings = {
      "-- Any extra CLI arguments for `ruff` go here.
      "args = {},
    "}
  "}
"}
"EOF


" 新增的行
"hi DiffAdd    ctermbg=235  ctermfg=108  guibg=#262626 guifg=#87af87 cterm=reverse gui=reverse
"变化的行
"hi DiffChange ctermbg=235  ctermfg=103  guibg=#262626 guifg=#8787af cterm=reverse gui=reverse
" 删除的行
"hi DiffDelete ctermbg=235  ctermfg=131  guibg=#262626 guifg=#af5f5f cterm=reverse gui=reverse
" 变化的文字
"hi DiffText   ctermbg=235  ctermfg=208  guibg=#262626 guifg=#ff8700 cterm=reverse gui=reverse

" 设置vimdiff时的颜色配置.
set t_Co=256
if ! has("gui_running")
    set t_Co=256
    endif
if &diff
    colors delek
    "colors blue
endif


"git 显示信息
"
lua << EOF
require("gitblame").setup({
  -- 可自定义显示模板，例如：
  enabled = true,
  delay = 500,
  template = "<author> • <date> • <summary>",
  date_format = "%Y-%m-%d"
})
EOF

