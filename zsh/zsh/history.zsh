HISTFILE=$HOME/.histfile
HISTSIZE=100000000
SAVEHIST=100000000
# setopt inc_append_history_time # similar to share_history but not immediate
setopt share_history
setopt extended_history  # save timestamps in history
setopt hist_ignore_space # ignore lines beginning w/ space

function hgrep() { fc -Dlim "*$@*" }
