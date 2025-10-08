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
	[[ "${MOON_DISABLE_GIT_PROMPT}" ]] && exit
	git rev-parse --is-inside-work-tree >/dev/null 2>&1
	if [[ "$?" = 0 ]]; then
		local dirty="$(git status --porcelain)"
		local branch="$(git rev-parse --abbrev-ref HEAD)"
		if [[ "${branch}" = 'HEAD' ]]; then
			branch="dtch@$(git rev-parse --short=8 HEAD)"
		fi
		printf " (${branch}%%F{red}${dirty:+*}%%f)"
	fi
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
