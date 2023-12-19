
[[ $- != *i* ]] && return

[[ -f ~/.aliases ]] && . ~/.aliases

[[ -f ~/.env ]] && . ~/.env

for file in ~/.aliases-*; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		. "$file"
	fi
done

for file in ~/.env-*; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		. "$file"
	fi
done

[[ -f ~/.bashrc-private ]] && . ~/.bashrc-private

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye > /dev/null

set -o vi

. ~/.git-prompt.sh
export PROMPT_COMMAND='__git_ps1 "\w" "\\\$ "'

export TERM=xterm-256color

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
	exec tmux new-session -A -s ${USER} >/dev/null 2>&1
fi

