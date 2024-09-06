


syntax on
set cursorline
set encoding=utf-8
set ts=4 
set sts=4 
set expandtab
set shiftwidth=4
set history=10000
set nu
set hlsearch
set showmatch
set bg=dark

" 设置搜索时不区分大小写
set ignorecase
set smartcase

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
Plug 'morhetz/gruvbox'

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
call plug#end()

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

lua << EOF
lspconfig = require("lspconfig")
lspconfig.pylsp.setup {
    on_attach = custom_attach,
    settings = {
        pylsp = {
        plugins = {
            black = { enabled = false },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            pylint = { enabled = false, executable = "pylint" },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            pylsp_mypy = { enabled = false },
            jedi_completion = { fuzzy = true },
            pyls_isort = { enabled = false },
        },
        },
    },
    flags = {
        debounce_text_changes = 200,
    },
}
EOF


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
" nnoremap <F8> :silent!!black %<CR>:e<CR>


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

autocmd vimenter * nested colorscheme gruvbox
let g:gruvbox_contrast_dark = 'medium'
:abbr emb from IPython import embed;embed()
autocmd BufNewFile *.py exec ":call SetPy()"
func SetPy()
    call setline(1, "# ===========================================")
    call append(line("."), "# -*- coding: utf-8 -*-")
    call append(line(".")+1, "# file: ".expand("%:t"))
    call append(line(".")+2, "# author: xxx")
    call append(line(".")+3, "# date: ".strftime("%Y-%m-%d"))
    call append(line(".")+4, "# ===========================================")
    call append(line(".")+5, "")
    call append(line(".")+6, "")
    call append(line(".")+7, "import os, sys, glob, click")
    call append(line(".")+8, "from loguru import logger")
    call append(line(".")+9, "")
    call append(line(".")+10, "")
    call append(line(".")+11, "@logger.catch")
    call append(line(".")+12, "@click.command()")
    call append(line(".")+13, "@click.option('--root', type=int, default=None)")
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
   resize 10
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


