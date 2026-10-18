" ----------------------------------------------------------------
" Config: Vim Classic Resilient Configuration
" ----------------------------------------------------------------

" ================================
" GERAL
" ================================

" --------------------------------
" Essenciais
" --------------------------------
set nocompatible
filetype plugin indent on
syntax on
set encoding=UTF-8

let s:is_raw_tty = ($RAW_TTY ==# '1' || $TERM ==# 'linux' || $TERM ==# 'cons25' || $TERM =~# '^vt[0-9]' || (empty($DISPLAY) && empty($WAYLAND_DISPLAY) && empty($SSH_CONNECTION) && empty($SSH_TTY) && !empty($TERM) && $TERM !~? 'xterm-256color|alacritty|kitty|foot|wezterm|ghostty'))
let s:is_ssh = (!empty($SSH_CONNECTION) || !empty($SSH_CLIENT) || !empty($SSH_TTY))

let s:is_win = has('win32') || has('win64')
let s:user_vim_dir = s:is_win ? expand('$HOME/vimfiles') : expand('$HOME/.vim')
if s:is_win && isdirectory(s:user_vim_dir) && stridx(&runtimepath, s:user_vim_dir) == -1
    let &runtimepath = s:user_vim_dir . ',' . &runtimepath . ',' . s:user_vim_dir . '/after'
endif

let s:vim_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
if stridx(&runtimepath, s:vim_dir) == -1
    let &runtimepath = s:vim_dir . ',' . &runtimepath . ',' . s:vim_dir . '/after'
endif
if filereadable(s:vim_dir . '/autoload/plug.vim') && !exists('*plug#begin')
    execute 'source ' . fnameescape(s:vim_dir . '/autoload/plug.vim')
endif

" --------------------------------
" Interface & Visual
" --------------------------------
set number
set relativenumber
set cursorline
set scrolloff=10
set showmode
set showcmd
set wildmenu
set wildmode=list:longest

" --------------------------------
" Busca
" --------------------------------
set incsearch
set hlsearch
set ignorecase
set smartcase

" --------------------------------
" Comportamento do Editor
" --------------------------------
set hidden
set nobackup
set noswapfile
set nowrap
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]
set mouse=a
if has('mouse_sgr')
    set ttymouse=sgr
endif
set clipboard^=unnamed,unnamedplus
set ttimeout
set ttimeoutlen=50

" --------------------------------
" Indentacao
" --------------------------------
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent

" --------------------------------
" Cores & TTY Fallback
" --------------------------------
if s:is_raw_tty
    if has('termguicolors')
        set notermguicolors
    endif
    set t_Co=16
else
    if has('termguicolors')
        set termguicolors
    endif
endif
set background=dark

" ================================
" PLUGINS
" ================================
if exists('*plug#begin')
    call plug#begin()

        " --------------------------------
        " Interface (Resiliente)
        " --------------------------------
        if !s:is_raw_tty
            Plug 'ryanoasis/vim-devicons'
            Plug 'vim-airline/vim-airline'
        endif
        Plug 'tomasiser/vim-code-dark'

        " --------------------------------
        " Ferramentas & FZF
        " --------------------------------
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        Plug 'preservim/nerdtree'
        Plug 'mg979/vim-visual-multi'
        Plug 'tpope/vim-surround'
        Plug 'vim-scripts/Tagbar'

        " --------------------------------
        " Linguagens & Sintaxe
        " --------------------------------
        Plug 'sheerun/vim-polyglot'
        Plug 'GabrielFrigo4/fasm.vim'
        Plug 'kylelaker/riscv.vim'
        Plug 'ARM9/arm-syntax-vim'

    call plug#end()
endif

" ================================
" MAPEAMENTOS & INTEGRACAO FZF
" ================================
let mapleader="\\"

" --------------------------------
" Navegacao de Janelas
" --------------------------------
nnoremap <tab> :wincmd w<CR>
nnoremap ; :wincmd w<CR>
nnoremap <M-]> :wincmd w<CR>

" --------------------------------
" NERDTree
" --------------------------------
nnoremap <C-\> :NERDTreeToggle<CR>
nnoremap , :NERDTreeToggle<CR>
nnoremap <M-[> :NERDTreeToggle<CR>

" --------------------------------
" FZF & Submodulos
" --------------------------------
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    let g:fzf_default_command = $FZF_DEFAULT_COMMAND
elseif executable('fd')
    let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
    let g:fzf_default_command = $FZF_DEFAULT_COMMAND
else
    let $FZF_DEFAULT_COMMAND = 'git ls-files --recurse-submodules --cached --others --exclude-standard 2>/dev/null || find . -type f'
    let g:fzf_default_command = $FZF_DEFAULT_COMMAND
endif

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }
let g:fzf_preview_window = ['right:50%:hidden', '?']

nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Rg<CR>

" --------------------------------
" Utilitarios
" --------------------------------
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <expr> <Backspace> col('.') == 1 ? 'kgJ' : 'X'

" --------------------------------
" Comentarios Nativos (Zero-Plugin)
" --------------------------------
function! s:ToggleComment() abort
    let l:lead = exists('b:comment_leader') ? b:comment_leader :
        \ (&filetype ==# 'vim' ? '" ' :
        \ (&filetype =~# '^\(c\|cpp\|rust\|go\|javascript\|typescript\|java\)$' ? '// ' : '# '))
    let l:line = getline('.')
    let l:esc = escape(l:lead, '/*~')
    if l:line =~# '^\s*' . l:esc
        call setline('.', substitute(l:line, '^\(\s*\)' . l:esc, '\1', ''))
    else
        call setline('.', substitute(l:line, '^\(\s*\)', '\1' . l:lead, ''))
    endif
endfunction

nnoremap <silent> gcc :call <SID>ToggleComment()<CR>
vnoremap <silent> gc :<C-u>'<,'>call <SID>ToggleComment()<CR>

" ================================
" CUSTOMIZACAO & FILETYPES
" ================================

" --------------------------------
" Tema & Fallback
" --------------------------------
if s:is_raw_tty
    silent! colorscheme default
else
    silent! colorscheme codedark
endif

if s:is_ssh || s:is_raw_tty
    let g:airline_powerline_fonts = 0
endif

" --------------------------------
" Estilo do Cursor
" --------------------------------
if s:is_raw_tty
    set guicursor=
else
    au VimEnter,VimResume * set guicursor=n-c:block,i-ci-ve:ver25,r-cr:hor10,o:hor50,v:hor10,a:blinkwait500-blinkoff500-blinkon500-Cursor/lCursor
    au VimLeave,VimSuspend * set guicursor=
endif

if $TERM ==# 'linux'
    let &t_vi = "\<Esc>[?25l"
    let &t_ve = "\<Esc>[?25h"
    let &t_VS = "\<Esc>[?25h"
    let &t_SI = "\<Esc>[?2c"
    let &t_SR = "\<Esc>[?4c"
    let &t_EI = "\<Esc>[?6c"
    let &t_te = "\<Esc>%G\<Esc>[?16;238;0c"
    if exists('##ModeChanged') && exists('*echoraw')
        augroup LinuxTTYCursor
            autocmd!
            autocmd VimEnter * call echoraw("\<Esc>[?6c")
            autocmd ModeChanged *:i* call echoraw("\<Esc>[?2c")
            autocmd ModeChanged *:c* call echoraw("\<Esc>[?3c")
            autocmd ModeChanged *:[rR]* call echoraw("\<Esc>[?4c")
            execute "autocmd ModeChanged *:v*,*:V*,*:\<C-V\>*,*:s*,*:S*,*:\<C-S\>* call echoraw(\"\\<Esc>[?5c\")"
            autocmd ModeChanged *:n* call echoraw("\<Esc>[?6c")
            if exists('##CmdlineEnter')
                autocmd CmdlineEnter * call echoraw("\<Esc>[?3c")
                autocmd CmdlineLeave * call echoraw("\<Esc>[?6c")
            endif
            autocmd VimLeave,VimSuspend * call echoraw("\<Esc>%G\<Esc>[?16;238;0c")
        augroup END
    endif
else
    let &t_SI = "\<Esc>[5 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[1 q"
endif


" --------------------------------
" ManPages
" --------------------------------
runtime! ftplugin/man.vim

" --------------------------------
" Assembly
" --------------------------------
augroup AssemblyConfig
    autocmd!
    autocmd BufNewFile,BufRead *.riscv,*.rinc,*.RISCV,*.RINC set filetype=riscv
    autocmd BufNewFile,BufRead *.arm,*.ainc,*.ARM,*.AINC     set filetype=arm
    autocmd BufNewFile,BufRead *.x86,*.x64,*.xinc            set filetype=nasm
    autocmd BufNewFile,BufRead *.fasm,*.finc                 set filetype=fasm
    autocmd BufNewFile,BufRead *.masm,*.minc                 set filetype=masm
    autocmd BufNewFile,BufRead *.gas,*.ginc                  set filetype=asm

    autocmd FileType asm,nasm,fasm,masm,riscv,arm,c,cpp,rust,go,python,lua
        \ setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab autoindent
augroup END
