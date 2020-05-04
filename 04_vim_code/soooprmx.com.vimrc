"===============================================================================
"FILE: myvimrc
"CREATED BY: sooop
"LAST UPDATEd:    2014. 04. 23.
"DESCRIPTION:
" my vimrc settting
" github repository : https://github.com/sooop/myvimrc.git
"===============================================================================


"SECTION: General Settings {{{1
"===============================================================================
"TOPIC: vim general {{{2
"------------------------
set nocompatible
set backspace=indent,start,eol
set showmatch
set visualbell


"TOPIC: gvim's window size {{{2
if has('gui')
    set columns=150
    set lines=38
endif


"TOPIC: tab settings {{{2
"-------------------------
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4    "this option allow backspace to move along tabs.
set smartindent
set autoindent


"TOPIC: filetype plugin setting {{{2
"-------------------------
filetype off "for vundle


"TOPIC: enable syntax highlighting {{{2
"-------------------------
if has('syntax')
    syntax on
endif


"TOPIC: Toggling Comment (via functions) {{{2
"----------------------------------------
"FUNCTIONS: for toggle comments {{{3
"FUCNTION: set comment's prefix character based on filetype
"-----------------------------------------------------------
function! SetCommentPrefix()
    let s:comment_prefix = "#"
    if &filetype == "vim"
        " for vim, inline comment start with \"
        let s:comment_prefix = "\""
    elseif &filetype ==? "c" || &filetype ==? "objc" || &filetype ==? "cpp"
        let s:comment_prefix = "//"
    endif
endfunction

"FUCNTION: Make given line into Comment
"----------------------------------------
function! CommentLine(line_number)
    call SetCommentPrefix()
    " remember current cursor position
    let cpos = getpos(".")
    " move to seletced line
    call setpos(".", [0, a:line_number, 0, 0])
    " just insert comment prefix character at the front of given line
    exec "normal! I".s:comment_prefix
     "restore cursor position
    call setpos(".", cpos)
endfunction

"FUNCTION: Uncomment given line
"-------------------------------
function! UncommentLine(line_number)
    call SetCommentPrefix()
    " remember current cursor position
    let cpos = getpos(".")
    "move to selected line
    call setpos(".", [0, a:line_number, 0, 0])
    " remove comment prefix charactor
    " !!! use escape() for some languages's prefix eg. C=> "//"
    exec ".s/".escape(s:comment_prefix, s:comment_prefix[0])."//"
    " restore cursor position
    call setpos(".", cpos)
endfunction


"FUNCTION: Check given line number if the line is comment
"---------------------------------------------------------
"ARGS: line_number
"RETURN: 1: the line is comment, 0: the line is not comment
"-----------------------------------------------------------
function! CheckIsComment(line_number)
    " check the line for given line number is comment
    let sl = getline(a:line_number)
    let c = 0
    while c < strlen(sl)
        let d = c + strlen(s:comment_prefix) - 1
        " sl[c] is space or tabe?
        if  " \t" =~ sl[c]
            " ignore indentation
            " pass
        elseif sl[(c):(d)] == s:comment_prefix
            return 1
        else
            return 0
        endif
        let c += 1
    endwhile
    return 0
endfunction

"FUNCTION: Toogle line comment
"------------------------------
function! ToggleCommentLine()
    call SetCommentPrefix()
    let cl = line(".")
    if CheckIsComment(cl)
        call UncommentLine(cl)
    else
        call CommentLine(cl)
    endif
endfunction


"FUNCTION: Toggle Range comment
"-------------------------------
function! ToggleCommentRange()
    call SetCommentPrefix()
    let line_begin = line("'<")
    let line_end = line("'>")
    " decide mode with first line in selection
    let mode_ = CheckIsComment(line_begin)
    let cpos = getpos(".")
    let i = line_begin
    while i < line_end + 1
        if mode_
            call UncommentLine(i)
        else
            call CommentLine(i)
        endif
        let i+=1
    endwhile
endfunction

"MAPPING: maps for comment toggling
"-----------------------------------
nnoremap <leader>0 :call ToggleCommentLine()<cr>
nnoremap <leader>\ :call ToggleCommentLine()<cr>
vnoremap <leader>0 <esc> :call ToggleCommentRange()<cr>
vnoremap <leader>\ <esc> :call ToggleCommentRange()<cr>
nnoremap <c-/> :call ToggleCommentLine()<cr>
nnoremap <c-;> :call ToggleCommentLine()<cr>
vnoremap <c-/> <esc> :call ToggleCommentRange()<cr>

"TOPIC: mouse usage {{{2
"------------------------
if has('mouse')
    set mouse=a
endif

"TOPIC: text width
set tw=150

"TOPIC: search options {{{2
"---------------------------
set incsearch
set hlsearch


"SECTION: Mappings {{{1
"===============================================================================
"TOPIC: Mapping 1 {{{2
"-----------------
"set mapleader to "-"
let mapleader = "-"
"
">>>select All
nnoremap <F9> ggVG
inoremap <F9> <esc>ggVG
vnoremap <F9> <esc>ggVG
"
">>>copy to clipboard, paste from clipboard
nnoremap <F3> "+y
nnoremap <F4> "+gP
inoremap <F3> <esc>"+Yi
inoremap <F4> <esc>"+gpa
vnoremap <F3> "+y
vnoremap <F4> "+gP

">>> Another escaping in insert mode : tt
inoremap uu <esc>

"TOPIC: Session {{{2
if has('win32')
    nnoremap <s-F5> :so $home/vimfiles/mks.vim<cr>
    nnoremap <F5> :mks! $home/vimfiles/mks.vim<cr>
else
    nnoremap <s-F5> :so ~/.vim/mks.vim<cr>
    nnoremap <F5> :mks! ~/.vim/mks.vim<cr>
endif



"TOPIC: Tab key and indent {{{2
"--------------------------
nnoremap <leader><tab> >>
vnoremap <leader><tab> >>
nnoremap <leader><s-tab> <<
vnoremap <leader><s-tab> <<


"TOPIC: Host file {{{2
"----------------------
if has('win32')
    noremap <F12> :tabe c:/windows/system32/drivers/etc/hosts<cr>
    noremap <leader>ho :tabe c:/windows/system32/drivers/etc/hosts<cr>
else
    noremap <F12> :tabe /etc/hosts<cr>
    noremap <leader>ho :tabe /etc/hosts<cr>
endif


"TOPIC: vim file code foldings {{{2
"------------------------------
augroup vimcodefolding
    autocmd!
    autocmd FileType vim set foldmethod=marker
    autocmd FileType nnoremap <c-f> zA
augroup END


"TOPIC: clear search highlight {{{2
"-----------------------------------
noremap <F2> :nohls<cr>
inoremap <F2> <esc>:nohls<cr>a
nnoremap <leader>ch :nohls<cr>


"TOPIC: moving arround windows {{{2
"-----------------------------------
"nnoremap <c-e> <c-w>w<c-w>_
nnoremap <leader>wg <c-w><down>
nnoremap <leader>wG <c-w><up>
nnoremap <leader>wr <c-w>r
nnoremap <leader>w= <c-w>=
nnoremap <leader>wj <c-w>j
nnoremap <leader>wk <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l


"TOPIC: maps for search {{{2
"----------------------------
nnoremap <c-g> viwy/<c-r>"<cr>
vnoremap <c-g> y/<c-r>"<cr>
nnoremap <c-e> //<cr>v//e<cr>


"TOPIC: maps for line shifting
"------------------------------
nnoremap <leader>- ddkP
nnoremap <leader>_ ddp
nnoremap __ ddp
nnoremap <leader>lu ddkP
nnoremap <leader>ld ddp
"insert an empty line
nnoremap <leader>o O<esc>j

"TOPIC: mapping for eazy command
"--------------------------------
nnoremap ; :



"SECTION: Advanced Mapping, file type specific key maps {{{1
"===============================================================================
"TOPIC: open my vimrc {{{2
"--------------------------
noremap <leader>rv :tabe $MYVIMRC<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>


"TOPIC: split previous file window {{{2
"---------------------------------------
" with previous buffer
nnoremap <leader>vsp :vsplit #<cr>
" with current buffer
nnoremap <leader>vsb :vsplit %<cr>


"TOPIC: Braces {{{2
"-------------------
nnoremap <leader>) viw<esc>a)<esc>`<i(<esc>wll
nnoremap <leader>} viw<esc>a}<esc>`<i{<esc>wll
nnoremap <leader>] viw<esc>a]<esc>`<i[<esc>wll
nnoremap <leader>" viw<esc>a"<esc>`<i"<esc>wll
nnoremap <leader>' viw<esc>a'<esc>`<i'<esc>wll
nnoremap <leader>` viw<esc>a`<esc>`<i`<esc>wll
nnoremap <leader>* viw<esc>a*<esc>`<i*<esc>wll
nnoremap <leader>+ viw<esc>a**<esc>`<i**<esc>wll
"
vnoremap <leader>) <esc>a)<esc>`<i(<esc>wll
vnoremap <leader>} <esc>a}<esc>`<i{<esc>wl
vnoremap <leader>] <esc>a]<esc>`<i[<esc>wl
vnoremap <leader>" <esc>a"<esc>`<i"<esc>wl
vnoremap <leader>' <esc>a'<esc>`<i'<esc>wl
vnoremap <leader>` <esc>a`<esc>`<i`<esc>wl
vnoremap <leader>* <esc>a*<esc>`<i*<esc>wll
vnoremap <leader>+ <esc>a**<esc>`<i**<esc>wll




"SECTION: Filetype autocommands {{{1
"===============================================================================
"TOPIC: Python  {{{2
"--------------------
let s:python_ver = 27
let g:available_py_versions = [27, 34]

function! TogglePythonVersion()
    let s:python_ver = g:available_py_versions[(index(g:available_py_versions, s:python_ver) + 1) % len(g:available_py_versions)]
    "let s:python_ver = g:available_py_versions[1]
    call jedi#force_py_version(s:python_ver / 10)
    echom "Python version:".s:python_ver
endfunction

function! PyDebug()
    exec "normal w!"
    exec "normal !pdb".s:python_ver." %"
endfunction

function! PyRunSet()
    let os_name = GetOSName()
    if os_name == 'mac'
        exec "nnoremap <buffer> <F8> :w!<cr>:!python %<cr>"
    elseif os_name == 'win32'
        exec "nnoremap <buffer> <F8> :w!<cr>:!c:\\python".s:python_ver."\\python.exe %<cr>"
    endif
endfunction

command! -nargs=0 PySwitch call TogglePythonVersion()

augroup oPython
    autocmd!
    autocmd BufRead,BufNewFile *.py setlocal filetype=python
    autocmd FileType python nnoremap <buffer> <leader>rn :w!<cr>:!python %<cr>|
                \ set expandtab|
                \ nnoremap <buffer> <F6> :call ChangePythonVersion()<cr>|
                \ setlocal tw=80|
                \ inoremap <buffer> <F11> :PySwitch<cr>|
                \ nnoremap <leader>db :w!<cr>:!pdb %<cr>|
                \ call PyRunSet()

augroup END


"TOPIC: Filetype SCSS {{{2
"--------------------------
augroup oSCSS
    autocmd!
    autocmd BufWritePost *.scss silent exec "!sass %"


augroup END



"TOPIC: Filetype C {{{2
"-----------------------
augroup sooopClang
    autocmd!
    autocmd FileType c nnoremap <buffer> <leader>bl :w!<cr>:!pycc % -o %<<cr>|
                \ nnoremap <buffer> <F7> :w!<cr>:!pycc % -o %<<cr>|
                \ nnoremap <buffer> <F8> :w!<cr>:!%<<cr>|
                \ nnoremap <buffer> <F6> :w!<cr>:!clang --analyze %<cr>|
                \ nnoremap <buffer> <leader>rn :w!<cr>:!%<<cr>|
                \ setlocal cindent|
                \ setlocal nosmartindent|
                \ iabbr <buffer> intm int main(int argc, const char* argv[]) {<cr>
augroup END


"TOPIC: Objective-C {{{2
"------------------------
augroup sooopObjC
    autocmd!
    if has('win32')
        autocmd FileType objc nnoremap <buffer> <leader>bld :w!<cr>:!objc.py % <cr>|
                    \ nnoremap <buffer> <leader>run :!%<cr>|
                    \ nnoremap <buffer> <F7> :w!<cr>:!objc.py % -o %<<cr>|
                    \ nnoremap <buffer> <F6> :w!<cr>:!clang --analyze %<cr>|
                    \ nnoremap <buffer> <F8> :!%<<cr>
    else
        autocmd FileType objc nnoremap <buffer> <leader>bld :w!<cr>:!clang -objc % -fobjc-arc -fblocks -framework Foundation -o %<<cr>|
                    \ nnoremap <buffer> <F9> :w!<cr>:!clang --analyze %<cr>|
                    \ nnoremap <buffer> <leader>rn :!./%<<cr>|
                    \ nnoremap <buffer> <F7> :w!<cr>:!clang -objc % -fobjc-arc -fblocks -framework Foundation -o %<<cr>|
                    \ nnoremap <buffer> <f8> :!./%<<cr>
    endif
augroup END


"TOPIC: vim file {{{2
"--------------------
function! TitleSub()
    let s = strlen(getline("."))
    exec "normal! o\"\<esc>".s."a-\<esc>"
endfunction
"
"
augroup sooopVimL
    autocmd!
    autocmd BufWritePost *.vim :source %
    autocmd FileType vim setlocal number|
                \ setlocal ruler|
                \ nnoremap <buffer> <F7> :call TitleSub()<cr>|
                \ nnoremap <buffer> <F8> o"<esc>79a=<esc>k|
                \ nnoremap <buffer> fa :%g/{{{\d/normal zo<cr>:nohls<cr>|
                \ nnoremap <buffer> fc :%g/{{{\d/normal zc<cr>:nohls<cr>|
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END


"TOPIC: VIM HELPFILE {{{2
"--------------------
augroup VIMHELP__
    au!
    autocmd FileType help nnoremap <buffer> q :q!<cr>
augroup END


"TOPIC: Javascript {{{2
"-----------------------
augroup    sooopJS
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <F8> :!node %<cr>
augroup    END


"TOPIC: Markdown {{{2
"---------------------
"FUNCTIONS: make Header
function! MakeHeaderLining(linetype)
    let l = strlen(getline(line(".")))
    exec "normal! o"
    exec "normal! ".l."I".a:linetype
endfunction
augroup sooopmkd
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <F8> :call MakeHeaderLining("=")<cr>o<cr>|
                \ setlocal tw=1500|
                \ nnoremap <buffer> <F7> :call MakeHeaderLining("-")<cr>o<cr>|
                \ inoremap <buffer> <F8> <esc>:call MakeHeaderLining("=")<cr>o<cr>|
                \ vnoremap <buffer> <F7> <esc>:call MakeHeaderLining("-")<cr>o<cr>|
                \ vnoremap <buffer> <F8> <esc>:call MakeHeaderLining("=")<cr>o<cr>|
                \ command! -nargs=0 ExportPDF exec "!md2pdf %"|
                \ nnoremap <buffer> <F6> <esc>:call PyPasteHTML()<cr>|
                \ inoremap <buffer> <F7> <esc>:call MakeHeaderLining("-")<cr>o<cr>

    "autocmd FileType markdown colorscheme murphy
augroup END


"TOPIC: AppleScript {{{2
if !has('win32')
augroup oapplescript
    au!
    "autocmd BufRead, BufNewFile setlocal filetype=applescript
    autocmd FileType applescript nnoremap <buffer> <F8> :w<cr>:!osascript %<cr>|
                \ inoremap <buffer> <F8> <esc>:w<cr> :!osascript %<cr>|
augroup END
endif


"TOPIC: Perl {{{2

augroup operl
    au!
    autocmd BufRead,BufNewFile *.[pl|pm] setlocal filetype=perl
    autocmd FileType perl nnoremap <buffer> <F8> :w!<cr>:!perl %<cr>
augroup END


"SECTION: Convenient Functions {{{1
"===============================================================================
"TOPIC: goto next empty line {{{2
"----------------------------
function! GotoNextEmptyLine()
    exec "normal! j"
    while strlen(getline(".")) > 0 && (line(".") != line("$"))
        exec "normal! j"
    endwhile
endfunction

function! GotoPrevEmptyLine()
    exec "normal! k"
    while strlen(getline(".")) > 0 && (line(".") != 1)
        exec "normal! k"
    endwhile
endfunction

nnoremap <leader>n :call GotoNextEmptyLine()<cr>
nnoremap <leader>N :call GotoPrevEmptyLine()<cr>


"TOPIC: Get OS Name {{{2
"------------------------
function! GetOSName()
    for os_fullname in ["win32", "mac", "win16", "win64", "macunix", "os2", "unix"]
        if has(os_fullname)
            return os_fullname
        endif
    endfor
    return "unknown"
endfunction



"TOPIC: Convert content to HTML (for markdown)
"-----------------------------------------
function! PasteHTML()
    if has('win32')
        let new_content=system("c:\\python33\\python c:\\python33\\scripts\\markdown_py ".@%)
    else
        let new_content=system("python3 /usr/local/bin/markdown_py ".@%)
    endif
    call append('$', "=======================================")
    let lines = split(new_content, "\n")
    for __line in lines
        call append('$', __line)
    endfor
endfunction

function! PyPasteHTML()
    if has('python')
python3 << EP
try:
    from markdown import Markdown
except:
    Markdown = None

try:
    from jinja2 import Template
except:
    Template = None

import vim

def convert_to_html(content):
    if Markdown is None:
        return None
    md = Markdown()
    return md.convert(content)

def render_html(html_content):
    if html_content is None:
        return None
    if Template is None:
        return html_content
    with open('c:/apps/bin/base.html', 'rb') as f:
        tm = Template(f.read().decode('utf-8'))
    return tm.render(page={'content': html_content})


def append_html():
    current_buffer = vim.current.buffer
    content_body = "\n".join(current_buffer[:])
    current_buffer.append("="*80)
    converted_html = render_html(convert_to_html(content_body))
    for l in converted_html.split('\n'):
        current_buffer.append(l)

append_html()
EP
    endif
endfunction


"TOPIC: send to w {{{2
function! SPSendToW()
    "exec "normal! w!"
    let l:content = join(getline(1, '$'), '\n')
    let l:title = input('Title: ')
    redraw
    let l:upload_command = "!curl -X POST -d title=" .l:title. " -d keyword=" .l:title. " --data-urlencode content={".l:content."} http://w/add"
    exec l:upload_command
    echo "Finished"
endfunction



"SECTION: Custom Command

command! -nargs=0 SelectAll normal! "ggVG"
command! -nargs=0 CopyAll normal! "ggVG\"+y"
command! -nargs=0 SendToW call SPSendToW()

"SECTION: Normal Abbreviation {{{1
"TOPIC: general  misspell {{{2
iabbrev adn and
iabbrev tehn then
iabbrev eles else
iabbrev waht what
iabbrev optoin option
iabbrev yeild yield
iabbrev yiedl yield
iabbrev yeidl yield
iabbrev return return
iabbrev reqeust request
iabbrev recieve recieve
iabbrev reqiure require
iabbrev reqiurement requirement
iabbrev lamdba lambda
iabbrev execpt: except:
iabbrev excute execute
iabbrev curosr cursor
iabbrev ture true
iabbrev Ture True
iabbrev flase false
iabbrev Flase False
iabbrev prnit print
iabbrev oepn open


"TOPIC: command {{{2
cabbrev iab iabbrev
cabbrev aug augroup
cabbrev cab cabbrev
iabbrev cab cabbrev
iabbrev iab iabbrev
iabbrev aug augroup
iabbrev auc autocmd
iabbrev nno nnoremap
cabbrev nno nnoremap


"TOPIC: custom  {{{2
"--------------------
iabbrev vrc `~/.vimrc`


"SECTION: File Type Specific Abbreviation {{{1
"===============================================================================
"TOPIC: Python  {{{2
"--------------------
augroup sooopAbbrPython
    autocmd!
    autocmd FileType python iabbrev <buffer> #!c #!c:/python27/python.exe<cr>|
            \ iabbrev <buffer> #!u #!/usr/bin/python|
            \ iabbrev <buffer> #-* #-*-coding:utf-8|
            \ iabbrev <buffer> #-8 #-*-coding:utf-8|
            \ iabbrev <buffer> iff if :<left>|
            \ iabbrev <buffer> ifn if __name__ == "__main__":
augroup END


"TOPIC: c abbrevation {{{2
"--------------------------
augroup sooopAbbhrC
au!
autocmd FileType C iabbrev <buffer> intm int main(int argc, const char *argv[]){|
            \nnoremap <leader>ii 0v$<esc>`<i<<esc>`>a><esc>I#include<esc>$|
            \nnoremap <leader>im 0v$<esc>`<i"<esc>`>a"<esc>I#include<esc>$
augroup END




"SECTION: vim for windows only {{{1
"===============================================================================
if has('win32')
    set fileencoding=utf-8
    set encoding=utf-8
    language messages en_US
    if has('gui')
        set guifont=Envy_Code_R:h10:cANSI
        "set guifontwide=Dotumche:h10:cDEFAULT
        set guifontwide=Gulimche:h9:cDEFAULT
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        color codeschool
    else
        color default
    endif
    else
    if has('gui')
        set guifont=Envy\ Code\ R:h13
        colorscheme codeschool
    else
        colorscheme default
    endif
endif




"SECTION: color change function {{{1
"===============================================================================

"FUNCTION: PrepareColorList
"---------------------------
let s:colorindex = 0
function! PrepareColorList()
let s:colorlist = []
if !exists('s:colorlist[0]')
    let s:colorlist = split(glob("$VIMRUNTIME/colors/*.vim"), "\n")
    if has('win32')
        " ??? glob() : get all filelist fron given path and pattern.
        " ??? split() : split text into a list, using given saperator.
        " ??? map() :
        call extend(s:colorlist, split(glob("$HOME/vimfiles/colors/*.vim"), "\n"))
        call map(s:colorlist, 'strpart(v:val, strridx(v:val, "\\")+1, strlen(v:val) - strridx(v:val, "\\") - 5)')
    else
        call extend(s:colorlist, split(glob("$HOME/.vim/colors/*.vim"), "\n"))
        call map(s:colorlist, 'strpart(v:val, strridx(v:val, "/") +1, strlen(v:val) - strridx(v:val, "/") - 5)')
    endif
endif
endfunction

"FUNCTION: NextColor
"--------------------
function! NextColor()
call PrepareColorList()
if s:colorindex == len(s:colorlist) -1
    let s:colorindex = 0
else
    let s:colorindex += 1
endif
let s:colorname = get(s:colorlist, s:colorindex)
execute "color ".s:colorname
endfunction

"FUNCTION: DispColorName
"-------------------------
function! DispColorName()
"call PrepareColorList()
echo s:colorname
endfunction

"FUNCTION: PrevColor
"---------------------
function! PrevColor()
call PrepareColorList()
if s:colorindex == 0
    let s:colorindex = len(s:colorlist) - 1
else
    let s:colorindex -= 1
endif
let s:colorname = get(s:colorlist, s:colorindex)
execute "color ".s:colorname
endfunction


"TOPIC: key maps for color change {{{2
nnoremap <leader>ui :call DispColorName()<cr>
nnoremap <F10> :call NextColor()<cr>:call DispColorName()<cr>
nnoremap <s-F10> :call PrevColor()<cr>:call DispColorName()<cr>
nnoremap <leader>uu :call NextColor()<cr>




"SECTION: Bundle's settings {{{1
"===============================================================================
"TOPIC: Simplenote {{{2
"-----------------------
let g:SimplenoteFiletype = "markdown"
let g:SimplenoteUsername = "sooopd@daum.net"
let g:SimplenotePassword = "dhfpswltlavmfshxm129"


"TOPIC: YouCompleteMe Map {{{2
"------------------------------
if exists("*youcompleteme#Complete")
    " YCM is installed
    nnoremap <leader>dc :YcmCompleter GoToDeclaration<cr>
    nnoremap <leader>de :YcmCompleter GoToDefinition<cr>
    nnoremap <leader>dd :YcmCompleter GoToDefinitionElseDeclaration<cr>
    nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<cr>
    vnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<cr>
endif


"TOPIC: Jedi vim {{{2
"---------------------
" maps below are default setting. just refer.
"
" <leader>g : goto assignment command
" <leader>d : goto definition
" K         : documentation command
" <leader>r : rename
" call sign : 1
let g:jedi#popup_select_first=0
let g:jedi#popup_on_dot=0


"TOPIC: Powerline {{{2
"----------------------
let g:laststatus = 2

"TOPIC: AirLine {{{2
"-------------------
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

"TOPIC: Syntastic {{{2
"---------------------
" C
"augroup Syntastic_C
    "au!
    "au FileType c let g:syntastic_c_check_header = 1
"augroup END

"TOPIC: emmet {{{2


"SECTION: Vundle Settings {{{1
"===============================================================================
"TOPIC: Vundle installation settings {{{2
"------------------------------------
if has('win32')
    set rtp+=~/vimfiles/bundle/Vundle.vim
    let s:vundlepath='~/vimfiles/bundle'
else
    set rtp+=~/.vim/bundle/Vundle.vim
    let s:vundlepath='~/.vim/bundle'
endif

call vundle#begin(s:vundlepath)

if system('uname') =~ 'Darwin'
    "You complete me
    if v:version > 703
        Bundle 'Valloric/YouCompleteMe'
    endif
endif



"-----------------------------------
"TOPIC: Manually Installed Packages {{{2
Bundle "pangloss/vim-javascript"
Bundle 'Markdown'
Bundle 'applescript.vim'
Bundle 'bling/vim-airline'
Bundle 'davidhalter/jedi-vim'
Bundle 'ervandew/supertab'
Bundle 'gmarik/Vundle.vim'
Bundle 'marijnh/tern_for_vim'
Bundle 'mattn/emmet-vim'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'mrtazz/simplenote.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/vim-auto-save'

call vundle#end()
filetype plugin indent on