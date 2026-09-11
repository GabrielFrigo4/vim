" ============================================================================
"  GERAL
" ============================================================================ {{{

" --- Essenciais ---
set nocompatible
filetype plugin indent on
syntax on
set encoding=UTF-8

let s:vim_dir = expand('<sfile>:p:h')
if stridx(&runtimepath, s:vim_dir) == -1
    let &runtimepath = s:vim_dir . ',' . &runtimepath . ',' . s:vim_dir . '/after'
endif
if filereadable(s:vim_dir . '/autoload/plug.vim') && !exists('*plug#begin')
    execute 'source ' . fnameescape(s:vim_dir . '/autoload/plug.vim')
endif

" --- Interface & Visual ---
set number
set relativenumber
set cursorline
set scrolloff=10
set showmode
set showcmd
set wildmenu
set wildmode=list:longest

" --- Busca ---
set incsearch
set hlsearch
set ignorecase
set smartcase

" --- Comportamento do Editor ---
set hidden
set nobackup
set noswapfile
set nowrap
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]
set mouse=a
set clipboard^=unnamed,unnamedplus

" --- Indentação (Padrão 4 espaços) ---
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent

" --- Cores ---
if (has("termguicolors"))
    set termguicolors
endif
set background=dark

" }}}


" ============================================================================
"  PLUGINS (Vim-Plug)
" ============================================================================ {{{

if exists('*plug#begin')
    call plug#begin()

        " --- Interface ---
        Plug 'ryanoasis/vim-devicons'
        Plug 'tomasiser/vim-code-dark'
        Plug 'vim-airline/vim-airline'

        " --- Ferramentas ---
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        Plug 'preservim/nerdtree'
        Plug 'mg979/vim-visual-multi'
        Plug 'tpope/vim-surround'
        Plug 'vim-scripts/Tagbar'

        " --- Linguagens (Geral) ---
        Plug 'sheerun/vim-polyglot'

        " --- Assembly (Específico) ---
        Plug 'GabrielFrigo4/fasm.vim'
        Plug 'kylelaker/riscv.vim'
        Plug 'ARM9/arm-syntax-vim'

    call plug#end()
endif

" }}}


" ============================================================================
"  MAPEAMENTOS
" ============================================================================ {{{

let mapleader="\\"

" --- Navegação de Janelas ---
nnoremap <tab> :wincmd w<CR>
nnoremap ; :wincmd w<CR>
nnoremap <M-]> :wincmd w<CR>

" --- NERDTree ---
nnoremap <C-\> :NERDTreeToggle<CR>
nnoremap , :NERDTreeToggle<CR>
nnoremap <M-[> :NERDTreeToggle<CR>

" --- FZF (Busca) ---
nnoremap <C-f> :Files<CR>
nnoremap <C-g> :Rg<CR>

" --- Utilitários ---
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <expr> <Backspace> col('.') == 1 ? 'kgJ' : 'X'

" }}}


" ============================================================================
"  CUSTOMIZAÇÃO & FILETYPES
" ============================================================================ {{{

" --- Tema ---
silent! colorscheme codedark

" --- Estilo do Cursor ---
au VimEnter,VimResume * set guicursor=n-c:block,i-ci-ve:ver25,r-cr:hor10,o:hor50,v:hor10,a:blinkwait500-blinkoff500-blinkon500-Cursor/lCursor
au VimLeave,VimSuspend * set guicursor=
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[1 q"

" --- ManPages ---
runtime! ftplugin/man.vim

" --- Assembly Configuration ---
augroup AssemblyConfig
    autocmd!
    " Definições de Extensão
    autocmd BufNewFile,BufRead *.riscv,*.rinc,*.RISCV,*.RINC set filetype=riscv
    autocmd BufNewFile,BufRead *.arm,*.ainc,*.ARM,*.AINC     set filetype=arm
    autocmd BufNewFile,BufRead *.x86,*.x64,*.xinc            set filetype=nasm
    autocmd BufNewFile,BufRead *.fasm,*.finc                 set filetype=fasm
    autocmd BufNewFile,BufRead *.masm,*.minc                 set filetype=masm
    autocmd BufNewFile,BufRead *.gas,*.ginc                  set filetype=asm

    " Formatação Unificada
    autocmd FileType asm,nasm,fasm,masm,riscv,arm,c,cpp,rust,go,python,lua
        \ setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab autoindent
augroup END

" }}}
