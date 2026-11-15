" ----------------------------------------------------------------
" Config: Vim Classic Resilient Configuration
" ----------------------------------------------------------------

" ================================
" GERAL
" ================================

" --------------------------------
" ESSENCIAIS
" --------------------------------
set nocompatible
filetype plugin indent on
syntax on
set encoding=UTF-8

let s:is_gui_pty = (!empty($DISPLAY) || !empty($WAYLAND_DISPLAY) || (filereadable('/proc/self/fd/0') && resolve('/proc/self/fd/0') =~# '^/dev/pts/'))
if s:is_gui_pty
    silent! unlet $RAW_TTY
    silent! unlet $LC_RAW_TTY
    silent! unlet $UNIVERSAL_RAW_TTY
endif

let s:is_win = has('win32') || has('win64')
let s:is_win_con = s:is_win && !has('gui_running') && &term ==# 'win32'
let s:is_win_vtp = s:is_win_con && (has('vcon') || !empty($WT_SESSION))
let s:is_raw_tty = !s:is_win && ($RAW_TTY ==# '1' || $TERM ==# 'linux' || $TERM ==# 'cons25' || $TERM =~# '^vt[0-9]' || (empty($DISPLAY) && empty($WAYLAND_DISPLAY) && empty($SSH_CONNECTION) && empty($SSH_TTY) && empty($WT_SESSION) && !empty($TERM) && $TERM !~? 'xterm-256color\|alacritty\|kitty\|foot\|wezterm\|ghostty'))
let s:is_ssh = (!empty($SSH_CONNECTION) || !empty($SSH_CLIENT) || !empty($SSH_TTY))

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
" INTERFACE & VISUAL
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
" BUSCA
" --------------------------------
set incsearch
set hlsearch
set ignorecase
set smartcase

" --------------------------------
" COMPORTAMENTO DO EDITOR
" --------------------------------
set hidden
set nobackup
set noswapfile
set nowrap
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]
set mouse=a
if has('mouse_sgr') && $TERM !=# 'linux'
    set ttymouse=sgr
endif
if s:is_raw_tty && $TERM !=# 'linux'
    let &t_TI .= "\<Esc>[?1000h\<Esc>[?1002h\<Esc>[?1006h"
    let &t_TE .= "\<Esc>[?1006l\<Esc>[?1002l\<Esc>[?1000l"
endif
set clipboard^=unnamed,unnamedplus
set ttimeout
set ttimeoutlen=50

" --------------------------------
" INDENTACAO
" --------------------------------
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent

" --------------------------------
" CORES & TTY FALLBACK
" --------------------------------
if s:is_raw_tty
    if has('termguicolors')
        set notermguicolors
    endif
    set t_Co=16
elseif s:is_win_con
    if has('vcon')
        if &t_Co < 256
            set t_Co=256
        endif
        if has('termguicolors')
            set termguicolors
        endif
    else
        if has('termguicolors')
            set notermguicolors
        endif
    endif
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
        " INTERFACE RESILIENTE
        " --------------------------------
        if !s:is_raw_tty
            Plug 'ryanoasis/vim-devicons'
            Plug 'vim-airline/vim-airline'
        endif
        Plug 'tomasiser/vim-code-dark'

        " --------------------------------
        " FERRAMENTAS & FZF
        " --------------------------------
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        Plug 'preservim/nerdtree'
        Plug 'mg979/vim-visual-multi'
        Plug 'tpope/vim-surround'
        Plug 'vim-scripts/Tagbar'

        " --------------------------------
        " LINGUAGENS & SINTAXE
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
" NAVEGACAO & PALAVRAS
" --------------------------------
nnoremap <tab> :wincmd w<CR>
nnoremap ; :wincmd w<CR>
nnoremap <M-]> :wincmd w<CR>
if !has('gui_running')
    execute "silent! set <C-Left>=\<Esc>[1;5D"
    execute "silent! set <C-Right>=\<Esc>[1;5C"
endif
nnoremap <silent> <C-Left> b
nnoremap <silent> <C-Right> w
inoremap <silent> <C-Left> <C-o>b
inoremap <silent> <C-Right> <C-o>w
nnoremap <silent> <Esc>[1;5D b
nnoremap <silent> <Esc>[1;5C w
inoremap <silent> <Esc>[1;5D <C-o>b
inoremap <silent> <Esc>[1;5C <C-o>w
nnoremap <silent> <Esc>[5D b
nnoremap <silent> <Esc>[5C w
inoremap <silent> <Esc>[5D <C-o>b
inoremap <silent> <Esc>[5C <C-o>w

" --------------------------------
" NERDTREE
" --------------------------------
nnoremap <C-\> :NERDTreeToggle<CR>
nnoremap , :NERDTreeToggle<CR>
nnoremap <M-[> :NERDTreeToggle<CR>

" --------------------------------
" FZF & SUBMODULOS
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
" UTILITARIOS
" --------------------------------
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <expr> <Backspace> col('.') == 1 ? 'kgJ' : 'X'

" --------------------------------
" COMENTARIOS NATIVOS
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
" TEMA & FALLBACK
" --------------------------------
function! s:ApplyRawTTYHighlights() abort
    set nocursorcolumn
    highlight Normal         cterm=NONE ctermfg=7  ctermbg=NONE
    highlight NonText        cterm=NONE ctermfg=8  ctermbg=NONE
    highlight EndOfBuffer    cterm=NONE ctermfg=8  ctermbg=NONE
    highlight SpecialKey     cterm=NONE ctermfg=8  ctermbg=NONE
    highlight LineNr         cterm=NONE ctermfg=8  ctermbg=NONE
    highlight CursorLine     cterm=NONE ctermfg=NONE ctermbg=NONE
    highlight CursorLineNr   cterm=bold ctermfg=11 ctermbg=NONE
    highlight Visual         cterm=NONE ctermfg=15 ctermbg=4
    highlight Search         cterm=NONE ctermfg=0  ctermbg=11
    highlight IncSearch      cterm=bold ctermfg=0  ctermbg=9
    highlight StatusLine     cterm=bold ctermfg=15 ctermbg=4
    highlight StatusLineNC   cterm=NONE ctermfg=7  ctermbg=8
    highlight VertSplit      cterm=NONE ctermfg=8  ctermbg=NONE
    highlight Pmenu          cterm=NONE ctermfg=7  ctermbg=8
    highlight PmenuSel       cterm=bold ctermfg=15 ctermbg=4
    highlight Comment        cterm=NONE ctermfg=8  ctermbg=NONE
    highlight Constant       cterm=NONE ctermfg=13 ctermbg=NONE
    highlight Number         cterm=NONE ctermfg=10 ctermbg=NONE
    highlight Boolean        cterm=NONE ctermfg=12 ctermbg=NONE
    highlight String         cterm=NONE ctermfg=11 ctermbg=NONE
    highlight Character      cterm=NONE ctermfg=11 ctermbg=NONE
    highlight Identifier     cterm=NONE ctermfg=14 ctermbg=NONE
    highlight Function       cterm=bold ctermfg=11 ctermbg=NONE
    highlight Statement      cterm=bold ctermfg=13 ctermbg=NONE
    highlight Keyword        cterm=bold ctermfg=12 ctermbg=NONE
    highlight Conditional    cterm=bold ctermfg=13 ctermbg=NONE
    highlight Repeat         cterm=bold ctermfg=13 ctermbg=NONE
    highlight Operator       cterm=NONE ctermfg=7  ctermbg=NONE
    highlight PreProc        cterm=NONE ctermfg=13 ctermbg=NONE
    highlight Type           cterm=NONE ctermfg=6  ctermbg=NONE
    highlight Special        cterm=NONE ctermfg=14 ctermbg=NONE
    highlight Directory      cterm=bold ctermfg=12 ctermbg=NONE
    highlight Error          cterm=bold ctermfg=15 ctermbg=1
    highlight ErrorMsg       cterm=bold ctermfg=15 ctermbg=1
    highlight WarningMsg     cterm=bold ctermfg=11 ctermbg=NONE
    highlight MatchParen     cterm=bold,underline ctermfg=14 ctermbg=NONE
endfunction

if s:is_raw_tty
    silent! colorscheme habamax
    if !exists('g:colors_name') || g:colors_name !=# 'habamax'
        silent! colorscheme default
    endif
    call s:ApplyRawTTYHighlights()
else
    silent! colorscheme codedark
endif

if s:is_ssh || s:is_raw_tty
    let g:airline_powerline_fonts = 0
endif

" --------------------------------
" ESTILO DO CURSOR
" --------------------------------
if exists('&guicursor')
    augroup CursorGuiConfig
        autocmd!
        if s:is_raw_tty || s:is_win_vtp
            set guicursor=
        elseif s:is_win_con
            autocmd VimEnter,VimResume * set guicursor=n-v-sm:block,i-ci:hor15,c:hor15,r-cr:hor50,o:hor50,ve:hor35
            autocmd VimLeave,VimSuspend * set guicursor=
        else
            autocmd VimEnter,VimResume * set guicursor=n-v-sm:block,i-ci:ver25,c:ver25,r-cr:hor50,o:hor50,ve:ver35,a:blinkwait600-blinkoff600-blinkon600-Cursor/lCursor
            autocmd VimLeave,VimSuspend * set guicursor=
        endif
    augroup END
endif

let s:r_pending = 0
let s:last_cursor_mode = ''

function! s:scale_tone(alpha) abort
    let l:col = synIDattr(synIDtrans(hlID('Cursor')), 'bg#')
    if empty(l:col) || l:col !~# '^#[0-9a-fA-F]\{6\}$'
        let l:col = synIDattr(synIDtrans(hlID('Normal')), 'fg#')
    endif
    let l:bg = synIDattr(synIDtrans(hlID('Normal')), 'bg#')
    if empty(l:bg) || l:bg !~# '^#[0-9a-fA-F]\{6\}$'
        let l:bg = (&background ==# 'light') ? '#ffffff' : '#000000'
    endif
    if empty(l:col) || l:col !~# '^#[0-9a-fA-F]\{6\}$'
        let l:col = (&background ==# 'light') ? '#000000' : '#ffffff'
    endif
    let l:cr = str2nr(strpart(l:col, 1, 2), 16)
    let l:cg = str2nr(strpart(l:col, 3, 2), 16)
    let l:cb = str2nr(strpart(l:col, 5, 2), 16)
    let l:br = str2nr(strpart(l:bg, 1, 2), 16)
    let l:bg_g = str2nr(strpart(l:bg, 3, 2), 16)
    let l:bb = str2nr(strpart(l:bg, 5, 2), 16)
    let l:nr = min([255, max([0, float2nr(round(l:cr * a:alpha + l:br * (1.0 - a:alpha)))])])
    let l:ng = min([255, max([0, float2nr(round(l:cg * a:alpha + l:bg_g * (1.0 - a:alpha)))])])
    let l:nb = min([255, max([0, float2nr(round(l:cb * a:alpha + l:bb * (1.0 - a:alpha)))])])
    return printf('#%02x%02x%02x', l:nr, l:ng, l:nb)
endfunction

function! s:cursor_mode_kind(mode) abort
    if a:mode =~# '^no' || a:mode =~# '^R' || a:mode ==# 'cr' || a:mode ==# 'cvr'
        return 'replace'
    elseif a:mode =~# '^c'
        return 'cmdline'
    elseif a:mode =~# '^i'
        return 'insert'
    elseif a:mode =~# '^[vV\x16sS\x13]'
        return 'visual'
    endif
    return 'normal'
endfunction

function! s:pty_seq(shape, alpha) abort
    if s:is_win_con
        return "\<Esc>[" . a:shape . " q"
    endif
    return "\<Esc>[" . a:shape . " q\<Esc>]12;" . s:scale_tone(a:alpha) . "\<C-g>"
endfunction

function! s:cursor_seq(mode) abort
    let l:kind = s:cursor_mode_kind(a:mode)
    if !s:is_win && $TERM ==# 'linux'
        if l:kind ==# 'insert'
            return "\<Esc>[?2c"
        elseif l:kind ==# 'cmdline'
            return "\<Esc>[?3c"
        elseif l:kind ==# 'replace'
            return "\<Esc>[?4c"
        elseif l:kind ==# 'visual'
            return "\<Esc>[?5c"
        endif
        return "\<Esc>[?6c"
    elseif s:is_raw_tty
        if l:kind ==# 'insert'
            return "\<Esc>]12;" . s:scale_tone(0.92) . "\<C-g>"
        elseif l:kind ==# 'cmdline'
            return "\<Esc>]12;" . s:scale_tone(0.84) . "\<C-g>"
        elseif l:kind ==# 'replace'
            return "\<Esc>]12;" . s:scale_tone(0.76) . "\<C-g>"
        elseif l:kind ==# 'visual'
            return "\<Esc>]12;" . s:scale_tone(0.68) . "\<C-g>"
        endif
        return "\<Esc>]12;" . s:scale_tone(1.0) . "\<C-g>"
    endif
    if l:kind ==# 'insert'
        return s:pty_seq(5, 0.92)
    elseif l:kind ==# 'cmdline'
        return s:pty_seq(5, 0.84)
    elseif l:kind ==# 'replace'
        return s:pty_seq(3, 0.76)
    elseif l:kind ==# 'visual'
        return s:pty_seq(1, 0.68)
    endif
    return s:pty_seq(1, 1.0)
endfunction

function! s:sync_cursor(mode, force) abort
    if !exists('*echoraw')
        return
    endif
    if !a:force && a:mode ==# s:last_cursor_mode
        return
    endif
    let s:last_cursor_mode = a:mode
    call echoraw(s:cursor_seq(a:mode))
endfunction

if !has('gui_running') && !s:is_win && $TERM ==# 'linux'
    if exists('&t_vi')
        let &t_vi = "\<Esc>[?25l"
        let &t_ve = "\<Esc>[?25h"
        let &t_VS = "\<Esc>[?25h"
    endif
    if exists('&t_SI')
        let &t_SI = "\<Esc>[?2c"
        let &t_SR = "\<Esc>[?4c"
        let &t_EI = "\<Esc>[?6c"
        let &t_te = "\<Esc>%G\<Esc>[?16;238;0c"
    endif
    if exists('##ModeChanged') && exists('*echoraw')
        augroup LinuxTTYCursor
            autocmd!
            autocmd VimEnter,VimResume * call s:sync_cursor(mode(1), 1)
            autocmd ModeChanged * if !s:r_pending | call s:sync_cursor(v:event.new_mode, 0) | endif
            if exists('##CmdlineEnter')
                autocmd CmdlineEnter * call s:sync_cursor(mode(1), 0)
                autocmd CmdlineLeave * call s:sync_cursor('n', 0)
            endif
            autocmd VimLeave,VimSuspend * let s:last_cursor_mode = '' | call echoraw("\<Esc>%G\<Esc>[?16;238;0c")
        augroup END
    endif
elseif !has('gui_running') && s:is_raw_tty
    if exists('##ModeChanged') && exists('*echoraw')
        augroup FreeBSDTTYCursor
            autocmd!
            autocmd VimEnter,VimResume * call s:sync_cursor(mode(1), 1)
            autocmd ModeChanged * if !s:r_pending | call s:sync_cursor(v:event.new_mode, 0) | endif
            if exists('##CmdlineEnter')
                autocmd CmdlineEnter * call s:sync_cursor(mode(1), 0)
                autocmd CmdlineLeave * call s:sync_cursor('n', 0)
            endif
            autocmd ColorScheme * let s:last_cursor_mode = '' | call s:sync_cursor(mode(1), 1)
            autocmd VimLeave,VimSuspend * let s:last_cursor_mode = '' | call echoraw("\<Esc>]112\<C-g>")
        augroup END
    endif
elseif !has('gui_running') && (!s:is_win_con || s:is_win_vtp)
    if exists('&t_SI')
        let &t_SI = "\<Esc>[5 q"
        let &t_SR = "\<Esc>[3 q"
        let &t_EI = "\<Esc>[1 q"
        if stridx(&t_ti, "\<Esc>[1 q") == -1
            let &t_ti .= "\<Esc>[1 q"
        endif
        if stridx(&t_te, "\<Esc>[1 q") == -1
            let &t_te .= "\<Esc>[1 q"
        endif
    endif
    if exists('&t_SH')
        let &t_SH = "\<Esc>[%d q"
    endif
    if exists('##ModeChanged') && exists('*echoraw')
        augroup PTYCursor
            autocmd!
            autocmd VimEnter,VimResume * call s:sync_cursor(mode(1), 1) | if s:is_win_con | let s:last_cursor_mode = '' | endif
            autocmd ModeChanged * if !s:r_pending | call s:sync_cursor(v:event.new_mode, 0) | endif
            if exists('##CmdlineEnter')
                autocmd CmdlineEnter * call s:sync_cursor(mode(1), 0)
                autocmd CmdlineLeave * call s:sync_cursor('n', 0)
            endif
            if s:is_win_con
                if exists('##ShellCmdPost') && exists('##FocusGained')
                    autocmd ShellCmdPost,FocusGained * call s:sync_cursor(mode(1), 1) | let s:last_cursor_mode = ''
                endif
                if exists('##SafeState')
                    autocmd SafeState * if !s:r_pending && mode(1) !=# s:last_cursor_mode | call s:sync_cursor(mode(1), 1) | endif
                endif
            else
                autocmd ColorScheme * let s:last_cursor_mode = '' | call s:sync_cursor(mode(1), 1)
            endif
            autocmd VimLeave,VimSuspend * let s:last_cursor_mode = '' | call echoraw(s:is_win_con ? "\<Esc>[1 q" : "\<Esc>[1 q\<Esc>]112\<C-g>")
        augroup END
    endif
endif

function! s:end_r() abort
    let s:r_pending = 0
    call s:sync_cursor(mode(1), 1)
endfunction

function! s:start_r(is_insert) abort
    if has('gui_running') || (s:is_win_con && !s:is_win_vtp)
        return a:is_insert ? "\<C-o>r" : 'r'
    endif
    if exists('*echoraw')
        call echoraw(s:cursor_seq('R'))
        if exists('##SafeState')
            let s:r_pending = 1
            autocmd SafeState * ++once call s:end_r()
        endif
    endif
    return a:is_insert ? "\<C-o>r" : 'r'
endfunction
nnoremap <expr> <silent> r <SID>start_r(0)
inoremap <expr> <silent> <C-o>r <SID>start_r(1)

" --------------------------------
" MANPAGES
" --------------------------------
runtime! ftplugin/man.vim

" --------------------------------
" ASSEMBLY
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

" --------------------------------
" TERMINAL EMBUTIDO
" --------------------------------
if has('terminal')
    let g:terminal_ansi_colors = [
        \ '#000000', '#cd3131', '#0dbc79', '#e5e510',
        \ '#2472c8', '#bc3fbc', '#11a8cd', '#e5e5e5',
        \ '#666666', '#f14c4c', '#23d18b', '#f5f543',
        \ '#3b8eea', '#d670d6', '#29b8db', '#ffffff'
        \ ]
    tnoremap <Esc> <C-W>N
    tnoremap <C-\><C-n> <C-W>N
    augroup VimTerminalConfig
        autocmd!
        autocmd TerminalOpen * setlocal nonumber norelativenumber signcolumn=no
        if s:is_gui_pty
            autocmd TerminalOpen * silent! unlet $RAW_TTY $LC_RAW_TTY $UNIVERSAL_RAW_TTY
        endif
    augroup END
endif
