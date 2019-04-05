export GOPATH=$HOME/go
export GOROOT=/usr/local/go

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/sapatel/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colorize zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

#export PATH=~/bin:$PATH
export PATH=$GOPATH/bin:$PATH

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias tree="tree -C"

# STARTUP SCRIPTS
default_proxy() {
    export http_proxy="http://httpproxy.bfm.com:8080"
    export https_proxy="http://sftpproxy.bfm.com:8080"
    export no_proxy=".local,.blkint.com,.bfm.com,.blackrock.com,.mlam.ml.com,*.local,*.blkint.com,*.bfm.com,*.blackrock.com,*.mlam.ml.com,localhost,127.0.0.1"
    export ftp_proxy="ftp://sftpproxy.bfm.com/"
    export all_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$https_proxy
    export NO_PROXY=$no_proxy
    export FTP_PROXY=$ftp_proxy
    export ALL_PROXY=$all_proxy

    echo "Confirm default proxy settings"
    env | grep -i proxy
    echo "Confirmation Complete"
}

pactester_proxy() {
    blk_proxy="$(echo "$pac_text" | pactester -p - -u http://google.com | cut -d\  -f2)"
    echo "Setting proxy to $blk_proxy"
    export HTTP_PROXY=http://"$blk_proxy"
    export HTTPS_PROXY=http://"$blk_proxy"
    export FTP_PROXY=ftp://"$blk_proxy"
    export NO_PROXY=".local,.blkint.com,.bfm.com,.blackrock.com,.mlam.ml.com,*.local,*.blkint.com,*.bfm.com,*.blackrock.com,*.mlam.ml.com,localhost,127.0.0.1"
    export ALL_PROXY=$HTTP_PROXY
    export http_proxy=$HTTP_PROXY
    export https_proxy=$HTTPS_PROXY
    export ftp_proxy=$FTP_PROXY
    export no_proxy=$NO_PROXY
    export all_proxy=$ALL_PROXY
}

unset_proxy() {
    if [ ! -z "$HTTP_PROXY""$HTTPS_PROXY""$NO_PROXY""$ALL_PROXY" ]; then
        echo "Unsetting proxy"
        unset HTTP_PROXY
        unset HTTPS_PROXY
        unset NO_PROXY
        unset ALL_PROXY
        unset FTP_PROXY

        unset http_proxy
        unset https_proxy
        unset no_proxy
        unset all_proxy
        unset ftp_proxy
    fi
    echo "Confirm proxy unset completed"
    env | grep -i proxy
    echo "Confirmation complete"
}

refresh_proxy() {
    if pac_text="$(networksetup -getautoproxyurl Wi-Fi | sed -n 's/^URL: //p;q' | xargs curl --noproxy \* -s)"; then
        echo "On the BLK network"
        if hash pactester 2>/dev/null; then
            echo "Using pactester to set proxy settings"
            pactester_proxy
        else
            echo "Pactester not available, setting default proxy settings"
            default_proxy
        fi
    else
        echo "No proxy found, unsetting proxies"
        unset_proxy
    fi
}

refresh_proxy >/dev/null


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"