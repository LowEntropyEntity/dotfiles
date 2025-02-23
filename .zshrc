export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
if [[ -n "$DEV_CONTAINER" ]]; then
	ZSH_THEME="refined"
else
	ZSH_THEME="robbyrussell"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto        # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# https://unix.stackexchange.com/questions/350797/zsh-git-filename-completion-with-git-dir-work-tree-not-a-git-repo
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.git-completion.bash

# fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts no
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# tmux
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-min-size 80 12

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.oh-my-zsh-custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git direnv fzf-tab)

source $ZSH/oh-my-zsh.sh

if command -v fzf &>/dev/null; then
	source <(fzf --zsh)
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

. ~/.aliases

setopt completealiases

if [ -f ~/.motd ]; then
	cat ~/.motd
fi

if command -v thefuck &>/dev/null; then
	eval $(thefuck --alias)
fi

if [ ! -f /.dockerenv ]; then
	export GPG_TTY="$(tty)"
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	gpg-connect-agent -q updatestartuptty /bye > /dev/null

	gpg -K | grep sean@sean.xyz 1>/dev/null 2>&1 || gpg --card-status 1> /dev/null || echo 'private key not found: run gpg --card-status\n'

	if [ ! -d ~/.password-store ]; then
		echo 'passwords not found, run: git clone git@github.com:LowEntropyEntity/pass ~/.password-store\n'
	fi

	if [ ! -d ~/media/pictures/wallpaper ]; then
		echo 'wallpaper not found, run: git clone git@github.com:LowEntropyEntity/wallpaper.git ~/media/pictures/wallpaper\n'
	fi

	if [ ! -d ~/src ]; then
		echo 'src not found, run: git clone git@github.com:LowEntropyEntity/src.git --recursive ~/src\n'
	fi

	GIT_DIR=$DOTFILES_GIT_DIR GIT_WORK_TREE=$DOTFILES_GIT_WORK_TREE git config set remote.origin.pushurl git@github.com:LowEntropyEntity/.dotfiles.git

fi

current_conflict_style=$(git config --global --get merge.conflictStyle || true)
if git --version | grep -Eq '\s2\.35|\s2\.[4-9][0-9]|\s[3-9]'; then
	if [ "$current_conflict_style" != "zdiff3" ]; then
		git config --global merge.conflictStyle zdiff3
	fi
else
	if [ "$current_conflict_style" != "diff3" ]; then
		git config --global merge.conflictStyle diff3
	fi
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
