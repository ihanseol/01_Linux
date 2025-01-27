
" Variables {{{
let s:is_windows = has('win32') || has('win64')
let s:is_nvim = has('nvim')
"}}}

" Setting up vim-plug as the package manager {{{
if !filereadable(expand("~/.vim/autoload/plug.vim"))
    echo "Installing vim-plug and plugins. Restart vim after finishing the process."
    silent call mkdir(expand("~/.vim/autoload", 1), 'p')
    execute "!curl -fLo ".expand("~/.vim/autoload/plug.vim", 1)." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall
endif

if s:is_windows
  set rtp+=~/.vim
endif

call plug#begin('~/.vim/plugged')
let g:plug_url_format = 'https://github.com/%s.git'
"}}}

set path+=**
set wildmenu
set laststatus=2

set langmenu=en_US.UTF-8
language messages en_US.UTF-8


call plug#begin()
    
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'
	Plug 'tpope/vim-surround'
	Plug 'itchyny/lightline.vim'
	Plug 'vim-scripts/peaksea'
	Plug 'raimondi/delimitmate'
	Plug 'flazz/vim-colorschemes'
    "" Plug 'python-mode/python-mode', { 'branch': 'develop' }
    Plug 'johngrib/vim-game-code-break'

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
call plug#end()


"---------------------------------------------------------------------------------------------------

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
	  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
	          \ &filetype ==# 'unite' ? unite#get_status_string() :
	          \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
	          \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  endfunction

  let g:unite_force_overwrite_statusline = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimshell_force_overwrite_statusline = 0

" Sample .vimrc file by Martin Brochhaus
"
"
" " Presented at PyCon APAC 2012
"
"
" " ============================================
" " Note to myself:
" " DO NOT USE <C-z> FOR SAVING WHEN PRESENTING!
" " ============================================
"
"
"Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %
"
"
" " Better copy & paste
" " When you want to paste large blocks of code into vim, press F2 before you
" " paste. At the bottom you should see ``-- INSERT (paste) --``.

 set pastetoggle=<F2>
 set clipboard=unnamed
"
"
" " Mouse and backspace
 set mouse=a  " on OSX press ALT and click
 set bs=2     " make backspace behave like normal again
"
"
" " Rebind <Leader> key
" " I like to have it here becuase it is easier to reach than the default and
" " it is next to ``m`` and ``n`` which I use for navigating between tabs.
 let mapleader = ","
"
"
" " Bind nohl
" " Removes highlight of your last search
" " ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
 noremap <C-n> :nohl<CR>
 vnoremap <C-n> :nohl<CR>
 inoremap <C-n> :nohl<CR>
"
"
" " Quicksave command
 noremap <C-Z> :update<CR>
 vnoremap <C-Z> <C-C>:update<CR>
 inoremap <C-Z> <C-O>:update<CR>
"
"
" " Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows

map <F3> :NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
"
"
" " bind Ctrl+<movement> keys to move around the windows, instead of using
" Ctrl+w + <movement>
" " Every unnecessary keystroke that can be saved is good for your health :)
 map <c-j> <c-w>j
 map <c-k> <c-w>k
 map <c-l> <c-w>l
 map <c-h> <c-w>h


" " easier moving between tabs
" 2019/12/26 tab switching ...
"
 map <Leader>c <esc>:tabnew<CR>
 map <Leader>n <esc>:tabprevious<CR>
 map <Leader>m <esc>:tabnext<CR>

" Go to tab by number
 noremap <leader>1 1gt
 noremap <leader>2 2gt
 noremap <leader>3 3gt
 noremap <leader>4 4gt
 noremap <leader>5 5gt
 noremap <leader>6 6gt
 noremap <leader>7 7gt
 noremap <leader>8 8gt
 noremap <leader>9 9gt
 noremap <leader>0 :tablast<cr>

" set relative number
"
 map <Leader>sr <esc>:set relativenumber<CR>
 map <Leader>sr! <esc>:set relativenumber!<CR>
"
"
" " map sort function to a key
 vnoremap <Leader>s :sort<CR>
"
"
" " easier moving of code blocks
" " Try to go into visual mode (v), thenselect several lines of code here and
" " then press ``>`` several times.
 vnoremap < <gv  " better indentation
 vnoremap > >gv  " better indentation
"
"
" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" " Enable syntax highlighting
" " You need to reload this file for the change to apply
" " filetype off
 filetype plugin on
 syntax on
"
"
" " Showing line numbers and length
 set number  " show line numbers
 set tw=79   " width of document (used by gd)
 set nowrap  " don't automatically wrap on load
 set fo-=t   " don't automatically wrap text when typing
 "set colorcolumn=100
 highlight ColorColumn ctermbg=233


 set nocompatible

" https://youtu.be/Q4I_Ft-VLAg
" 2019/12/19 - filetype autocmd setting ... by youtube ...
"
"map <F6> :setlocal spell! spelllang=en_US<CR>
"
"inoremap <Space><Space> <ESC>/<++><Enter>"_c41
"
"autocmd FileType html inoremap ;i <em></em><Space><++><Esc>FeT>i
"autocmd FileType html inoremap ;b <b></b><Space><++><Esc>FbT>i
"autocmd FileType html inoremap ;p <p></p><Enter><Enter><++><Esc>2ki
"


"------------------------------------------------------------------------------------------------------

"colorscheme monokai-chris
"colorscheme torte
"colorscheme tender


"colorscheme wombat256mod
"colorscheme monokain 
colorscheme mojave 
"------------------------------------------------------------------------------------------------------


"
" " easier formatting of paragraphs
vmap Q gq
nmap Q gqap


" " Useful settings
set history=700
set undolevels=700


" " Real programmers don't use TABs but spaces
 set tabstop=4
 set softtabstop=4
 set shiftwidth=4
 set shiftround
 set expandtab
"
"
" " Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" " Disable stupid backup and swap files - they trigger too many events
" " for file system watchers
set nobackup
set nowritebackup
set noswapfile


" GUI & Terminal setttings {{{
if has("gui_running")
  if has("gui_macvim")
    set guifont=Consolas:h15
  elseif has("gui_win32")
    autocmd GUIEnter * simalt ~x " open maximize in Windows
    set guifont=Consolas:h11
  endif
  "set guioptions= " disable all UI options
  set guicursor+=a:blinkon0 " disable blinking cursor
  set ballooneval
  autocmd GUIEnter * set novisualbell t_vb=
else
  set noerrorbells novisualbell t_vb=
  if !s:is_nvim
    set term=xterm
  endif
  set t_ut= " setting for looking properly in tmux
  set t_BE= " disable bracketed-paste mode
  let &t_Co = 256
  if s:is_windows " trick to support 256 colors and scroll in conemu
    let &t_AF="\e[38;5;%dm"
    let &t_AB="\e[48;5;%dm"
    inoremap <esc>[62~ <c-x><c-e>
    inoremap <esc>[63~ <c-x><c-y>
    nnoremap <esc>[62~ 3<c-e>
    nnoremap <esc>[63~ 3<c-y>
  endif
endif


set nofoldenable



" Cycle between line numbers, relative numbers, no numbers
if exists('+relativenumber')
  "CTRL-N is traditionally mapped to move the cursor down;
  "I never use it that way, and there are already four other
  "ways to do that
  nnoremap <expr> <Leader>n CycleLNum()
  xnoremap <expr> <Leader>n CycleLNum()
  onoremap <expr> <Leader>n CycleLNum()

  " function to cycle between normal, relative, and no line numbering
  function! CycleLNum()
    if &l:rnu
      setlocal nonu nornu
    elseif &l:nu
      setlocal nu rnu
    else
      setlocal nu
    endif
    " sometimes (like in op-pending mode) the redraw doesn't happen
    " automatically
    redraw
    " do nothing, even in op-pending mode
    return ""
  endfunc
endif

"
