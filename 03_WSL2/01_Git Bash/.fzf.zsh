# Setup fzf
# ---------
if [[ ! "$PATH" == */c/Users/minhwasoo/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/c/Users/minhwasoo/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/c/Users/minhwasoo/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/c/Users/minhwasoo/.fzf/shell/key-bindings.zsh"
