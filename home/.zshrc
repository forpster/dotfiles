# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git
#        zsh-interactive-cd
#        command-not-found
#        rvm
#        alias-finder
#        zsh-autosuggestions
#        autoupdate
#        zsh-syntax-highlighting)

#source $ZSH/oh-my-zsh.sh

# Brew paths
export PATH="/usr/local/sbin:$PATH"

# Use antigen
source $HOME/src/antigen/antigen.zsh

# Use Oh-My-Zsh
antigen use oh-my-zsh

# Set Theme
antigen theme romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Plugins
antigen bundles <<EOBUNDLES
git
command-not-found
alias-finder
docker
mvn
tmux
brew
zsh-interactive-cd
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-completions
fzf
fdellwing/zsh-bat
EOBUNDLES

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

[ -f ${HOME}/.fzf.zsh ] && source ${HOME}/.fzf.zsh

# Rapid7
[ -f ${HOME}/.bash_rapid7 ] && source ${HOME}/.bash_rapid7
[ -f ${HOME}/.bash_aws ] && source ${HOME}/.bash_aws

# GNU grep
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH

export EDITOR=vim
export PAGER=less
export LESS=MeqiwR

# C-a c-r to restore work first
alias tmuxwork='tmux new-session -t work'

# modern ls is a dick
export QUOTING_STYLE=literal

if [ -f ${HOME}/Documents/graphgl_api_key.txt ]; then
    export GRAPHQL_API_KEY=$(cat ${HOME}/Documents/graphgl_api_key.txt)
fi

if [ -f ${HOME}/Documents/github_token.txt ]; then
  export GITHUB_PACKAGES_PULL_USER="rkirk-nos"
  export GITHUB_PACKAGES_PULL_TOKEN=$(cat ${HOME}/Documents/github_token.txt)
fi

# Size of folders
alias dux='du -sk ./* | sort -n | awk '\''BEGIN{ pref[1]="K"; pref[2]="M"; pref[3]="G";} { total = total + $1; x = $1; y = 1; while( x > 1024 ) { x = (x + 1023)/1024; y++; } printf("%g%s\t%s\n",int(x*10)/10,pref[y],$2); } END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'\'''
alias dush="du -sm *|sort -n|tail"

alias remove_emacs_backup='find . -name "*~" -delete'
alias ec='emacsclient -n'
export PATH=$PATH:$HOME/bin

# Add Visual Studio Code (code), adding to path broke stuff i dunno
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

# Auto start tmux, fails under intellij
#ZSH_TMUX_AUTOSTART=true

# fix awslocal to work with old localstack for LA integrations
#export USE_LEGACY_PORTS=1

# Do not prompt rm to delete files
setopt rm_star_silent

# Apply bundles
antigen apply

# ASDF
export ASDF_DATA_DIR=/Users/rkirk/.asdf
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# asdf manage JAVA_HOME variable
. ~/.asdf/plugins/java/set-java-home.zsh

# completiton for 1pass cli
if [ -x /usr/local/bin/op2 ]; then
    eval "$(op completion zsh)"; compdef _op op
fi

# krew kubectl plugin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Put go bin folder on path
export PATH="$PATH:$(go env GOPATH)/bin"

# git clone https://github.com/junegunn/fzf-git.sh.git
# CTRL-GF	Look for git files with fzf
# CTRL-GB	Look for git branches with fzf
# CTRL-GT	Look for git tags with fzf
# CTRL-GR	Look for git remotes with fzf
# CTRL-GH	Look for git commit hashes with fzf
# CTRL-GS	Look for git stashes with fzf
# CTRL-GL	Look for git reflogs with fzf
# CTRL-GW	Look for git worktrees with fzf
# CTRL-GE	Look for git for-each-ref with fzf
[ -f ~/src/fzf-git.sh/fzf-git.sh ] && source ~/src/fzf-git.sh/fzf-git.sh

# ----- Bat (better cat) -----
# mkdir -p "$(bat --config-dir)/themes"
# cd "$(bat --config-dir)/themes"
# curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
export BAT_THEME_DARK=tokyonight_night

# SSH onto instance through jumphost
# Args
# 	1 - jumphost
# 	2 - instance to ssh onto
function jhssh() {
	ssh -J $1 $2
}

# Set up port forward from service to local port
#
# Args
# 	1 - jumphost
# 	2 - hostname:port to forward
# 	3 - local port to forward to
function jhpf() {
	ssh -A $1 -L $3:$2
}
