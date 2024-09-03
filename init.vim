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
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'L3MON4D3/LuaSnip'  
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
" 需要安: sudo apt-get install exuberant-ctags
" 下面的两个是neovim-remote的相关.类似于配置IDE
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

call plug#end()

" 加载插件
if filereadable(expand('~/.vim/plugged/plugin/installed.vim'))
  source ~/.vim/plugged/plugin/installed.vim
endif


"自动补全
lua << EOF
local cmp = require('cmp')

cmp.setup({
        snippet = {
     expand = function(args)
       require('luasnip').lsp_expand(args.body)
     end,
    
        },
        sources = cmp.config.sources({
     { name = 'nvim_lsp'  },
     { name = 'buffer'  },
     { name = 'path'  },  
    
                }),
        mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true  }),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    
        },

        })
EOF


lua << EOF
lspconfig = require("lspconfig")
lspconfig.pylsp.setup{}
EOF

nnoremap <F8> :lua vim.lsp.buf.code_action()<CR>



lua << EOF
lspconfig = require("lspconfig")
lspconfig.pylsp.setup {
on_attach = custom_attach,
          settings = {
              pylsp = {
                  plugins = {
        black = { enabled = false  },
        autopep8 = { enabled = false  },
        yapf = { enabled = false  },
        pylint = { enabled = false, executable = "pylint"  },
        pyflakes = { enabled = false  },
        pycodestyle = { enabled = false  },
        pylsp_mypy = { enabled = false  },
        jedi_completion = { fuzzy = true  },
        pyls_isort = { enabled = false  },
    
                  },
    
              },

          },
          flags = {
    debounce_text_changes = 200,

          },
capabilities = capabilities,

}
EOF


lua << EOF
local lspconfig = require('lspconfig')
lspconfig.texlab.setup{}
EOF


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
" 也可以用jedi,需要安对应的jedi的server
" let g:languageserver_python = {'server': 'jedi',}

" 设置快捷键 F6 列出引用并跳转到引用处, 引用有一些慢,还是定义比较快一些.
" nnoremap <F7> :lua vim.lsp.buf.references()<CR>
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
:abbr from IPython import embed;embed() from IPython import embed;embed()
autocmd BufNewFile *.py exec ":call SetPy()"
func SetPy()
    call setline(1, "# ===========================================")
    call append(line("."), "# --coding:UTF-8 --")
    call append(line(".")+1, "# file: ".expand("%:t"))
    call append(line(".")+2, "# author: xxxxxxxxxxxxxxxxx")
    call append(line(".")+3, "# date: ".strftime("%Y-%m-%d"))
    call append(line(".")+4, "# ===========================================")
    call append(line(".")+5, "")
    call append(line(".")+6, "")
    call append(line(".")+7, "import os, sys, glob")
    call append(line(".")+8, "from loguru import logger")
    call append(line(".")+9, "")
    call append(line(".")+10, "")
    call append(line(".")+11, "@logger.catch")
    call append(line(".")+12, "def main():")
    call append(line(".")+13, "")
    call append(line(".")+14, "")
    call append(line(".")+15, "")
    call append(line(".")+16, "")
    call append(line(".")+17, "if __name__ == '__main__':")
    call append(line(".")+18, "    main()")
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
map <F4> :TagbarToggle<CR>:wincmd r<CR>
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
   " execute "silent!term ".command
   execute "new | set bt=nofile | silent!term ".command
   wincmd k
   resize 10
endfunction


" 之前按Ctrl-w比较费劲,可以用F2来代替, 别忘记了按完F2后还要按上下键.
nnoremap <F2> <C-w>



"autopairs 配置
lua << EOF
local autopairs = require('nvim-autopairs')
-- 启用插件
autopairs.setup({
  -- 忽略某些字符后的自动补全
  ignore_next_char = '[%w%.]',
  -- 在某些特定的文件类型中禁用插件
  disable_filetype = { 'TelescopePrompt' },
  -- 设置自动补全的括号样式，例如圆括号、方括号、花括号等
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'PmenuSel',
    highlight_grey='LineNr',
  },
})
EOF


"lua << EOF
"local cmp = require('cmp')
"local autopairs = require('nvim-autopairs')
"-- 设置 cmp 的 completion_item_kind 以更好地显示成对符号
"cmp.setup({
  "formatting = {
    "format = function(entry, vim_item)
      "vim_item.kind = string.format('%s (%s)', vim_item.kind, autopairs.get_kind(entry))
      "return vim_item
    "end,
  "},
"})
"EOF



"lua << EOF
"local autopairs = require('nvim-autopairs')
"-- 创建自定义规则函数
"function custom_brackets_rule()
  "local pair = { open = '[{', close = '}]' } -- 例如，打开时输入 [{，自动补全为 [{}]
  "return pair
"end
"autopairs.add_rules({ custom_brackets_rule() })
"-- 将自定义规则添加到 nvim-autopairs 的规则列表中
"EOF
