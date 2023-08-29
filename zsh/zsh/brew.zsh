if [[ -e /opt/homebrew/bin/brew ]]; then
	export ZSH_HAS_HOMEBREW=1
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi