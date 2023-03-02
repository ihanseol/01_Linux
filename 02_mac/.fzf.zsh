# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/minhwasu/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/minhwasu/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/minhwasu/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/minhwasu/.fzf/shell/key-bindings.zsh"
