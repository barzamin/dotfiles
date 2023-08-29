dot_zsh=$HOME/.zsh

if (( $+ZSH_HAS_HOMEBREW )); then
	fpath=($dot_zsh/completions
		$(brew --prefix)/share/zsh/site-functions
		$fpath)
else
	fpath=($dot_zsh/completions
		$fpath)
fi

autoload -Uz compinit
compinit #-i # -i ignores insecure dirs
zstyle ':completion:*' accept-exact-dirs true # related to mount issue @ desres?
