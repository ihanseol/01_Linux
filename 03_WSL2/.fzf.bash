# Setup fzf
# ---------
if [[ ! "$PATH" == */home/hwasoo/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/hwasoo/.fzf/bin"
fi

eval "$(fzf --bash)"
