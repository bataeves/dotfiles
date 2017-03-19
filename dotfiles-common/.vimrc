" Drop total compatibility with ancient vi.
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Color scheme
Plugin 'altercation/vim-colors-solarized'
Plugin 'dracula/vim'

" GUI
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'alfredodeza/coveragepy.vim'
Plugin 'ervandew/supertab'

" Syntax
Plugin 'sheerun/vim-polyglot'
Plugin 'digitaltoad/vim-jade'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'vim-scripts/po.vim--gray'

" Editing
Plugin 'Chiel92/vim-autoformat'
Plugin 'Shougo/deoplete.nvim'
Plugin 'Raimondi/delimitMate'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'haya14busa/incsearch.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'fisadev/vim-isort'
Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-sensible'
Plugin 'kana/vim-fakeclip'

call vundle#end()            " required
filetype plugin indent on    " required

scriptencoding utf-8
set encoding=utf-8              " setup the encoding to UTF-8
set ls=2                        " status line always visible

" GUI
set number
set mouse=a
set mousehide
set wrap
set cursorline
set ttyfast
set title
set showcmd
set hidden
set ruler
set lazyredraw
set autoread
set ttimeoutlen=0
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" Editing
set expandtab                  " spaces instead of tabs
set tabstop=4                  " a tab = four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces
set backspace=indent,eol,start
set autoindent                 " set on the auto-indent
set foldmethod=indent          " automatically fold by indent level
set nofoldenable               " ... but have folds open by default"
set virtualedit=all
set textwidth=79
set colorcolumn=80
" highlight tabs and trailing spaces
" source: https://wincent.com/blog/making-vim-highlight-suspicious-characters
set listchars=nbsp:¬,eol:¶,tab:→\ ,extends:»,precedes:«,trail:•
" Leave Ex Mode, For Good
" source: http://www.bestofvim.com/tip/leave-ex-mode-good/
nnoremap Q <nop>


" Searching
set incsearch      " incremental searching
set showmatch      " show pairs match
set hlsearch       " highlight search results
set smartcase      " smart case ignore
set ignorecase     " ignore case letters


" History and permanent undo levels
set history=1000
set undofile
set undoreload=1000


" Color scheme.
" syntax enable
" set background=dark
" let g:solarized_termtrans = 1
" colorscheme solarized

syntax on
colorscheme dracula


" Font
set guifont=Source\ Code\ Pro:h11


" Make a dir if no exists
function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction


" Backups
set backup
set noswapfile
set backupdir=~/.vim_tmp/backup
set undodir=~/.vim_tmp/undo
set directory=~/.vim_tmp/swap
set viminfo+=n~/.vim_tmp/viminfo

" Make this dirs if no exists previously
silent! call MakeDirIfNoExists(&undodir)
silent! call MakeDirIfNoExists(&backupdir)
silent! call MakeDirIfNoExists(&directory)


" Delete trailing whitespaces
autocmd BufWritePre,FileWritePost * :%s/\s\+$//e
" Replace all non-breakable spaces by simple spaces
" Source: http://nathan.vertile.com/find-and-replace-non-breaking-spaces-in-vim/
autocmd BufWritePre,FileWritePost * silent! :%s/\%xa0/ /g
" Remove Byte Order Mark at the beginning
autocmd BufWritePre,FileWritePost * setlocal nobomb


" Airline
set noshowmode
let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_min_count = 1


" indentLine
let g:indentLine_char = '┊'
let g:indentLine_color_term = 239


" Git gutter
let g:gitgutter_max_signs = 10000


" JSON
" Disable concealing mode altogether.
let g:vim_json_syntax_conceal = 0


" Markdown
" Disable element concealing.
let g:vim_markdown_conceal = 0

"=====================================================
" Python-mode settings
"=====================================================
" отключаем автокомплит по коду (у нас вместо него используется jedi-vim)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" документация
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'

" проверка кода
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110"

" провека кода после сохранения
let g:pymode_lint_write = 1

" поддержка virtualenv
let g:pymode_virtualenv = 1

" установка breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" подстветка синтаксиса
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" отключить autofold по коду
let g:pymode_folding = 0

" возможность запускать код
let g:pymode_run = 0

" Disable choose first function/method at autocomplete
let g:jedi#popup_select_first = 0
