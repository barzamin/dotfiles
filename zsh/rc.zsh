dot_zsh=$HOME/.zsh
usrmodules=(
	'brew'
	'completion'
	'shellopt'
	'history'
	'path'
	'ld'
	'iterm2' # before prompt
	'prompt'
	'keys'
	'colors'
	'etc'
	#'nvm' # why the fuck is this so slow
	'devkitpro'

	# 3rd party
	'highlighting' # zsh-syntax-highlighting
)

for module in $usrmodules; {
	[[ -e $dot_zsh/$module.zsh ]] && source $dot_zsh/$module.zsh
}
