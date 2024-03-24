
# Aliases

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -ahF --color=tty'                 # classify files in colour
alias dir='ls -al --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -alF'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -alF'                              #


alias ..='cd ..'
alias .='pwd'

alias cdwin='cd /mnt/c/windows'
alias cd32='cd /mnt/c/windows/system32'
alias cd64='cd /mnt/c/Windows/SysWOW64'

alias cddata='cd /mnt/c/ProgramData'
alias cdprog='cd /mnt/c/ProgramData'
alias cdcmder='cd "/mnt/c/Program Files/totalcmd"'
alias cdtc='cd "/mnt/c/Program Files/totalcmd"'

alias cddev='cd /mnt/d/12_dev'
alias cddesk='cd /mnt/c/Users/minhwasoo/Desktop'
alias cddown='cd /mnt/c/Users/minhwasoo/Downloads/'
alias cdhome='cd  /mnt/c/Users/minhwasoo/'

alias cdappdata='cd /mnt/c/Users/minhwasoo/AppData/'
alias cdlocal='cd /mnt/c/Users/minhwasoo/AppData/Local/'

alias cdhost='cd  /mnt/c/Windows/System32/Drivers/etc/'

alias cdgame='cd /mnt/d/11_exaData/06_util/099_Game/'
alias cdsend='cd /mnt/d/05_Send/'
alias cdsend2='cd /mnt/d/06_Send2/'


alias vi='vim'


# git command ..

alias gl='git log --oneline --all --graph --decorate'

alias gs='git status'
alias ga='git add'
alias gc='git commit'

alias gpush='git push'
alias gpull='git pull'


alias cls='clear'
alias bload='source .bashrc'
alias zload='source .zshrc'

alias qal='cd; vi .bash_aliases'
alias qpr='cd; vi .bashrc'
alias zpr='cd; vi .zshrc'
alias zal='cd; vi .zsh_aliases'
