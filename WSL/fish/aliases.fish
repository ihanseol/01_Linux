# migrating from
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh 

# Aliases
alias g='git'
#compdef g=git
alias gst='git status'
#compdef _git gst=git-status
alias gd='git diff'
#compdef _git gd=git-diff
alias gdc='git diff --cached'
#compdef _git gdc=git-diff
alias gl='git pull'
#compdef _git gl=git-pull
alias gup='git pull --rebase'
#compdef _git gup=git-fetch
alias gp='git push'
#compdef _git gp=git-push
alias gd='git diff'


alias gl='git log --oneline --all --graph --decorate'
alias gs='git status'
alias ga='git add '
alias gc='git commit  -v '
alias gpush='git push origin master'
alias gpull='git pull origin master'



alias l='ls -al'
