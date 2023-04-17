dot_zsh=$HOME/.zsh

fpath=($dot_zsh/completions
	$(brew --prefix)/share/zsh/site-functions
	$fpath)

autoload -Uz compinit
compinit #-i # -i ignores insecure dirs
zstyle ':completion:*' accept-exact-dirs true # related to mount issue @ desres?
