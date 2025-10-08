typeset -U path # typeset unique-element array

path=(
	$HOME/bin
	$HOME/.local/bin
	$HOME/.local/go/bin
	$HOME/.cargo/bin
	$HOME/.cabal/bin
	$HOME/.ghcup/bin
	'/Applications/Sublime Text.app/Contents/SharedSupport/bin'
	$path
)
