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
	'gpg'
	#'nvm' # why the fuck is this so slow
	'devkitpro'

	# 3rd party
	'highlighting' # zsh-syntax-highlighting
)

#startup_log=$dot_zsh/startup.log
#t0=$(date +"%T.%N")
for module in $usrmodules; {
	#echo $module
	[[ -e $dot_zsh/$module.zsh ]] && source $dot_zsh/$module.zsh
	#t=$(date +"%T.%N")
}
