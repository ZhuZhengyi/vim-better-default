" default.vim - Better vim than the default
" Maintainer:   Liu-Cheng Xu <https://github.com/liuchengxu>
" Version:      1.0
" vim: et ts=2 sts=2 sw=2


if &compatible || exists('g:loaded_vim_better_default')
   finish
endif
let g:loaded_vim_better_default = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

" Neovim has set these as default
if !has('nvim')

  set nocompatible

  syntax on                      " Syntax highlighting
  filetype plugin indent on      " Automatically detect file types
  set autoindent                 " Indent at the same level of the previous line
  set autoread                   " Automatically read a file changed outside of vim
  set backspace=indent,eol,start " Backspace for dummies
  set complete-=i                " Exclude files completion
  set display=lastline           " Show as much as possible of the last line
  set encoding=utf-8             " Set default encoding
  set history=10000              " Maximum history record
  set hlsearch                   " Highlight search terms
  set incsearch                  " Find as you type search
  set laststatus=2               " Always show status line
  set mouse=a                    " Automatically enable mouse usage
  set smarttab                   " Smart tab
  set ttyfast                    " Faster redrawing
  set wildmenu                   " Show list instead of just completing
  set nobackup                   " No backup
  set modeline
  set ttymouse=xterm2
  if !has('nvim')
    set viminfo='100,n$HOME/.vim/files/info/viminfo
  endif
endif

augroup detect
    au FileType html,vue,markdown set tabstop=2
    au FileType html,vue,markdown set shiftwidth=2
augroup END

scriptencoding utf-8

set shortmess=atOI " No help Uganda information, and overwrite read messages to avoid PRESS ENTER prompts
set smartindent                " Smart indent
set ignorecase     " Case insensitive search
set smartcase      " ... but case sensitive when uc present
set scrolljump=5   " Line to scroll when cursor leaves screen
set scrolloff=3    " Minumum lines to keep above and below cursor
set nowrap         " Do not wrap long lines
set backspace=2                     "
set shiftwidth=4   " Use indents of 4 spaces
set tabstop=4      " An indentation every four columns
set softtabstop=4  " Let backspace delete indent
set cindent shiftwidth=4            "
set cmdheight=2                     " 命令行高度
set laststatus=2                    " 开启状态栏
set splitright     " Puts new vsplit windows to the right of the current
set splitbelow     " Puts new split windows to the bottom of the current
set autowrite      " Automatically write a file when leaving a modified buffer
set mousehide      " Hide the mouse cursor while typing
set hidden         " Allow buffer switching without saving
"set t_Co=256       " Use 256 colors
set ruler          " Show the ruler
set showcmd        " Show partial commands in status line and Selected characters/lines in visual mode
set showmode       " Show current mode in command-line
set showmatch      " Show matching brackets/parentthesis
set matchtime=5    " Show matching time
set report=0       " Always report changed lines
set linespace=0    " No extra spaces between rows
set pumheight=20   " Avoid the pop up menu occupying the whole screen

if !exists('g:vim_better_default_tabs_as_spaces') || g:vim_better_default_tabs_as_spaces
  set expandtab    " Tabs are spaces, not tabs
end

"set guifont=monaco\ 10              " 默认字体
"set guifont=Monaco\ Nerd\ Font\ Mono              " 默认字体
"set guifont=SauceCodePro\ Nerd\ Font\ Mono              " 默认字体
set guifont=ComicShannsMono\ Nerd\ Font\ Mono             " 默认字体
if has('win32') && has('gui_running')
    language message zh_CN.UTF-8
    set background=light            "设置主题整体为暗色调
endif

if !has('gui_running')
  set t_Co=256
endif

"恢复上次光标位置
if has('autocmd')
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" http://stackoverflow.com/questions/6427650/vim-in-tmux-background-color-changes-when-paging/15095377#15095377
set t_ut=

set winminheight=0
set wildmode=list:longest,full

"set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

set whichwrap+=<,>,h,l  " Allow backspace and cursor keys to cross line boundaries

set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,cp936,gb18030,gbk,gb2312,big5,latin1

set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip,*.un~
set wildignore+=*/tmp/*,*.o,*.obj,*.so     " Unix
set wildignore+=*\\tmp\\*,*.exe            " Windows

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk
"vmap j gj
"vmap k gk

nnoremap <leader>* :nohl<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" Change cursor shape for iTerm2 on macOS {
  " bar in Insert mode
  " inside iTerm2
  if $TERM_PROGRAM =~# 'iTerm'
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif

  " inside tmux
  if exists('$TMUX') && $TERM != 'xterm-kitty'
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  endif

  " inside neovim
  if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2
  endif
" }

if get(g:, 'vim_better_default_minimum', 0)
  finish
endif

if get(g:, 'vim_better_default_backup_on', 0)
  set backup
else
  set nobackup
  set noswapfile
  set nowritebackup
endif

if get(g:, 'vim_better_default_enable_folding', 1)
  set foldenable
  set foldmarker={,}
  set foldlevel=4
  set foldmethod=syntax
  au FileType python set foldmethod=marker
  " set foldcolumn=3
  set foldlevelstart=99
endif

set background=dark         " Assume dark background
"set cursorline              " Highlight current line
"au Filetype * highlight cursorline ctermbg=Black
set fileformats=unix,dos,mac        " Use Unix as the standard file type
set fileformat=unix                 " 默认文本格式
set number                  " Line numbers on
set relativenumber          " Relative numbers on
set fillchars=stl:\ ,stlnc:\ ,fold:\ ,vert:│

" Annoying temporary files
set directory=/tmp//,.
set backupdir=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

highlight clear SignColumn  " SignColumn should match background
" highlight clear LineNr      " Current line number row will have same background color in relative mode

if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
elseif $TMUX == ''
  set clipboard+=unnamed
endif

if get(g:, 'vim_better_default_persistent_undo', 0)
  if has('persistent_undo')
    set undodir=~/.undodir
    set undofile             " Persistent undo
    set undolevels=1000      " Maximum number of changes that can be undone
    set undoreload=10000     " Maximum number lines to save for undo on a buffer reload
  endif
endif

if has('gui_running')
  set guioptions-=r        " Hide the right scrollbar
  set guioptions-=L        " Hide the left scrollbar
  set guioptions-=T
  set guioptions-=e
  set shortmess+=c
  " No annoying sound on errors
  set noerrorbells
  set novisualbell
  set visualbell t_vb=
endif

function! CreateCenteredFloatingWindow() abort
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    let l:textbuf = nvim_create_buf(v:false, v:true)
    call nvim_open_win(l:textbuf, v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
    return l:textbuf
endfunction

function! FloatingWindowHelp(query) abort
    let l:buf = CreateCenteredFloatingWindow()
    call nvim_set_current_buf(l:buf)
    setlocal filetype=help
    setlocal buftype=help
    execute 'help ' . a:query
endfunction

command! -complete=help -nargs=? Help call FloatingWindowHelp(<q-args>)

" Key (re)Mappings {

  if get(g:, 'vim_better_default_key_mapping', 1)

    " Basic {
      if get(g:, 'vim_better_default_basic_key_mapping', 1)
        " Add <slient> for the rhs is Ex-cmd as some GUI app, e.g., gnvim,
        " flashes when you use these mappings.
        " Quit normal mode
        nnoremap <silent> <Leader>q  :q<CR>
        nnoremap <silent> <Leader>Q  :qa!<CR>
        " Move half page faster
        nnoremap <Leader>d  <C-d>
        nnoremap <Leader>u  <C-u>
        " Insert mode shortcut
        inoremap <C-h> <BS>
        inoremap <C-j> <Down>
        inoremap <C-k> <Up>
        inoremap <C-b> <Left>
        inoremap <C-f> <Right>
        " Bash like
        inoremap <C-a> <Home>
        inoremap <C-e> <End>
        inoremap <C-d> <Delete>
        " Command mode shortcut
        cnoremap <C-h> <BS>
        cnoremap <C-j> <Down>
        cnoremap <C-k> <Up>
        cnoremap <C-b> <Left>
        cnoremap <C-f> <Right>
        cnoremap <C-a> <Home>
        cnoremap <C-e> <End>
        cnoremap <C-d> <Delete>
        " jj | escaping
        inoremap jj <Esc>
        cnoremap jj <C-c>
        " Quit visual mode
        "vnoremap v <Esc>
        " Move to the start of line
        nnoremap H ^
        " Move to the end of line
        nnoremap L $
        " Redo
        nnoremap U <C-r>
        " Quick command mode
        nnoremap <CR> :
        " In the quickfix window, <CR> is used to jump to the error under the
        " cursor, so undefine the mapping there.
        autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
        " Yank to the end of line
        nnoremap Y y$
        " Auto indent pasted text
        " nnoremap p p=`]<C-o>
        " Open shell in vim
        if has('nvim') || has('terminal')
          map <silent> <Leader>' :terminal<CR>
        else
          map <silent> <Leader>' :shell<CR>
        endif
        " Search result highlight countermand
        nnoremap <silent> <Leader>sc :nohlsearch<CR>
        " Toggle pastemode
        nnoremap <silent> <Leader>tp :setlocal paste!<CR>
      endif
    " }

    " Buffer {
      if get(g:, 'vim_better_default_buffer_key_mapping', 1)
        nnoremap <silent> <Leader>bp :bprevious<CR>
        nnoremap <silent> <Leader>bn :bnext<CR>
        nnoremap <silent> <Leader>bf :bfirst<CR>
        nnoremap <silent> <Leader>bl :blast<CR>
        nnoremap <silent> <Leader>bd :bd<CR>
        nnoremap <silent> <Leader>bk :bw<CR>
      endif
    " }

    " File {
      if get(g:, 'vim_better_default_file_key_mapping', 1)
        " File save
        nnoremap <silent> <Leader>fs :update<CR>
      endif
    " }

    " Fold {
      if get(g:, 'vim_better_default_fold_key_mapping', 1)
        nnoremap <silent> <Leader>f0 :set foldlevel=0<CR>
        nnoremap <silent> <Leader>f1 :set foldlevel=1<CR>
        nnoremap <silent> <Leader>f2 :set foldlevel=2<CR>
        nnoremap <silent> <Leader>f3 :set foldlevel=3<CR>
        nnoremap <silent> <Leader>f4 :set foldlevel=4<CR>
        nnoremap <silent> <Leader>f5 :set foldlevel=5<CR>
        nnoremap <silent> <Leader>f6 :set foldlevel=6<CR>
        nnoremap <silent> <Leader>f7 :set foldlevel=7<CR>
        nnoremap <silent> <Leader>f8 :set foldlevel=8<CR>
        nnoremap <silent> <Leader>f9 :set foldlevel=9<CR>
      endif
    " }

    " Window {
      if get(g:, 'vim_better_default_window_key_mapping', 1)
        nnoremap <Leader>ww <C-W>w
        nnoremap <Leader>wr <C-W>r
        nnoremap <Leader>wd <C-W>c
        nnoremap <Leader>wq <C-W>q
        nnoremap <Leader>wj <C-W>j
        nnoremap <Leader>wk <C-W>k
        nnoremap <Leader>wh <C-W>h
        nnoremap <Leader>wl <C-W>l
        if has('nvim') || has('terminal')
          tnoremap <Leader>wj <C-W>j
          tnoremap <Leader>wk <C-W>k
          tnoremap <Leader>wh <C-W>h
          tnoremap <Leader>wl <C-W>l
        endif
        nnoremap <Leader>wH <C-W>5<
        nnoremap <Leader>wL <C-W>5>
        nnoremap <Leader>wJ :resize +5<CR>
        nnoremap <Leader>wK :resize -5<CR>
        nnoremap <Leader>w= <C-W>=
        nnoremap <Leader>ws <C-W>s
        nnoremap <Leader>w- <C-W>s
        nnoremap <Leader>wv <C-W>v
        nnoremap <Leader>w\| <C-W>v
        nnoremap <Leader>w2 <C-W>v
        nnoremap <C-h> <C-W>h
        nnoremap <C-j> <C-W>j
        nnoremap <C-k> <C-W>k
        nnoremap <C-l> <C-W>l
      endif
    " }

    function! Zoom ()
      " check if is the zoomed state (tabnumber > 1 && window == 1)
      if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose
        " restore the view
        if l:cur_bufname == bufname('')
          call winrestview(cur_winview)
        endif
      else
        tab split
      endif
    endfunction
    nnoremap <leader>z :call Zoom()<CR>

  endif

" }

autocmd BufWritePost $MYVIMRC source $MYVIMRC

let &cpo = s:save_cpo
unlet s:save_cpo



