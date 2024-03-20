
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
alias ll='ls -al'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -ACF'                              #


alias cdwin='cd /c/windows'
alias cd32='cd /c/windows/system32'
alias cd64='cd /c/Windows/SysWOW64'

alias cddata='cd /c/ProgramData'
alias cdprog='cd /c/ProgramData'
alias cdcmder='cd "/c/Program Files/totalcmd"'
alias cdtc='cd "/c/Program Files/totalcmd"'

alias cddev='cd /d/12_dev'
alias cddesk='cd /c/Users/minhwasoo/Desktop'
alias cddown='cd /c/Users/minhwasoo/Downloads/'
alias cdhome='cd  /c/Users/minhwasoo/'

alias cdappdata='cd /c/Users/minhwasoo/AppData/'
alias cdlocal='cd /c/Users/minhwasoo/AppData/Local/'

alias cdhost='cd  /c/Windows/System32/Drivers/etc/'

alias cdgame='cd /d/11_exaData/06_util/099_Game/'
alias cdsend='cd /d/05_Send/'
alias cdsend2='cd /d/06_Send2/'


alias vi='vim'

