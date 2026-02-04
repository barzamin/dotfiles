setopt prompt_subst

function p_arrow() {
	echo "%F{cyan}»%f"
}

function p_colored_path() {
	local slash="%F{cyan}/%f"
	echo "${${PWD/#$HOME/~}//\//$slash}"
}

function p_ssh_markings() {
	if [[ -n "${SSH_TTY}" ]]; then
		echo " $(hostname -s)"
	fi
}

function p_git_markings() {
	local branch dirty
	local tic toc dt

	tic=$(rightnow)
	[ -n "${MOON_DISABLE_GIT_PROMPT+1}" ] && exit
	git rev-parse --is-inside-work-tree >/dev/null 2>&1
	if [ $? -ne 0 ]; then return; fi

	branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
	# uninitialized repos will have HEAD pointing at refs/master/head
	# or similar, but that ref won't exist yet. early out
	if [ $? -ne 0 ] || [ -z $branch ]; then return; fi

	dirty="$(git status --porcelain)"
	if [[ "${branch}" = 'HEAD' ]]; then
		branch="dtch@$(git rev-parse --short=8 HEAD)"
	fi
	printf " (${branch}%%F{red}${dirty:+*}%%f)"

	#toc=$(rightnow)
	#dt=$((toc-tic))
	#echo $dt

	#if (( $dt > 0.15 )); then
	#	# too slow, disable for this repo until we exit it
	#	echo "disabling"
	#	typeset -gx MOON_GIT_PROMPT_TEMP_DISABLE_FOR=$(git rev-parse --show-toplevel)
	#fi
}

function p_sigil() {
	echo "%F{blue}λ%f"
}

prompt='$(p_sigil) $(p_colored_path)$(p_git_markings)$(p_ssh_markings)
'
if [[ -n "${ZSH_ITERM2_ACTIVE}" ]]; then
	prompt+='%{$(iterm2_prompt_mark)%}'
fi
prompt+='$(p_arrow) '

export ITERM2_SQUELCH_MARK=1
