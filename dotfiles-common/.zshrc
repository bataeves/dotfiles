# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git pip python yarn zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

DISABLE_AUTO_TITLE="true"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

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


# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Detect distribution
if [[ "$(uname -s)" == "Darwin" ]]; then
    IS_MACOS=true
else
    IS_MACOS=false
fi

# Do not let homebrew send stats to Google Analytics.
# See: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md#opting-out
if $IS_MACOS; then
    export HOMEBREW_NO_ANALYTICS=1
fi

# If possible, add tab completion for many more commands
autoload bashcompinit
bashcompinit
alias compopt='complete'
[ -f /etc/bash_completion ] && source /etc/bash_completion
source ~/.bash_completion.d/*.sh

if $IS_MACOS; then
    # Force Python, then Homebrew binaries to take precedence on macOS default
    PYTHON_LOCAL_BIN="$(python -m site --user-base)/bin"
    GNU_CORE_UTILS_BIN="$(brew --prefix coreutils)/libexec/gnubin"
    export PATH="$PYTHON_LOCAL_BIN:$GNU_CORE_UTILS_BIN:/usr/local/bin:/usr/local/sbin:$PATH"
    [ -f "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion"
    # test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
fi

# Setting history length
export HISTCONTROL="ignoredups:erasedups"
export HISTTIMEFORMAT="[%F %T] "
export HISTSIZE=999999
export HISTFILESIZE=$HISTSIZE;
# Make some commands not show up in history
export HISTIGNORE="ls:ll:cd:cd -:pwd:exit:date:history"

# # Append to the history file, don't overwrite it.
# shopt -s histappend
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# # Allow us to re-edit a failed history substitution.
# shopt -s histreedit
# # History expansions will be verified before execution.
# shopt -s histverify

# After each command, append to the history file and reread it.
# Source: https://unix.stackexchange.com/a/1292
# export GIT_PROMPT_SHOW_UNTRACKED_FILES=no
# export GIT_PROMPT_FETCH_REMOTE_STATUS=0

# закоментил, так как жуткие тормоза
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}; history -a;"

# Set user & root prompt
# if $IS_MACOS; then
#     GIT_PROMPT_THEME="Solarized"
# else
#     GIT_PROMPT_THEME="Solarized_UserHost"
# fi
# source ~/.bash-git-prompt/gitprompt.sh
# export SUDO_PS1='\[\e[31m\]\u\[\e[37m\]:\[\e[33m\]\w\[\e[31m\]\$\[\033[00m\] '

# Make Neovim the default editor
export EDITOR="vim"

# Set default ls color schemes (source: https://github.com/seebi/dircolors-solarized/issues/10 ).
# macOS/Linux color translations generated with http://geoff.greer.fm/lscolors/
if $IS_MACOS; then
    export TERM=xterm-256color
    export CLICOLOR=1
    export LSCOLORS="gxfxbEaEBxxEhEhBaDaCaD"
else
    export LS_COLORS="di=36;40:ln=35;40:so=31;:pi=0;:ex=1;;40:bd=0;:cd=37;:su=37;:sg=0;:tw=0;:ow=0;:"
fi

# Activate global dir colors if found.
if $IS_MACOS; then
    alias dircolors='gdircolors'
    alias show_hidden="defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder"
    alias hide_hidden="defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder"
fi
if [ -f $HOME/.dircolors ]
then
    eval "$(dircolors -b $HOME/.dircolors)"
else
    eval "$(dircolors -b)"
fi

# Force colored output and good defaults
alias du='du -csh'
alias df='df -h'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff="colordiff -ru"
alias dmesg="dmesg --color"
alias tree='tree -Csh'
alias ccat='pygmentize -g'

alias top="htop"
alias gr='grep -RIi --no-messages'
alias vi='vim'
alias v="vim"
alias g="git"
alias h="history"
alias q='exit'

function cls {
    if $IS_MACOS; then
        # Source: https://stackoverflow.com/a/2198403
        osascript -e 'tell application "System Events" to keystroke "k" using command down'
    else
        clear
    fi
}
alias c='cls'

# Use GRC for additionnal colorization
if $IS_MACOS; then
  GRC=$(which grc 2>/dev/null)
  if [ -n GRC ]; then
      alias colourify='$GRC -es --colour=auto'
      alias as='colourify as'
      #cvs
      alias configure='colourify ./configure'
      alias diff='colourify diff'
      alias dig='colourify dig'
      alias g++='colourify g++'
      alias gas='colourify gas'
      alias gcc='colourify gcc'
      alias head='colourify head'
      alias ifconfig='colourify ifconfig'
      #irclog
      alias ld='colourify ld'
      #ldap
      #log
      alias ls='colourify ls'
      alias make='colourify make'
      alias mount='colourify mount'
      #mtr
      alias netstat='colourify netstat'
      alias ping='colourify ping'
      #proftpd
      alias ps='colourify ps'
      alias tail='colourify tail'
      alias traceroute='colourify traceroute'
      #wdiff
  fi
fi

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    lsflags=("--color" "--group-directories-first")
else # macOS `ls`
    lsflags="-G"
fi
alias ll='ls -lah ${lsflags}'
alias ls='ls -hFp ${lsflags}'

# Handy aliases for going up in a directory
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"

export LESS="-eRX"
export LESSOPEN='| pygmentize -g %s'
# Tip from http://sourceforge.net/apps/trac/qlc/wiki/InstallationSubversionLinux#Optionalhelpers
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# Expose diff-so-fancy.
export PATH="$PATH:$HOME/.diff-so-fancy"

# Don't let Python produce .pyc or .pyo. Left-overs can produce strange side-effects.
export PYTHONDONTWRITEBYTECODE=true

# Python shell auto-completion and history
# export PYTHONSTARTUP="$HOME/.python_startup.py"

# Display DeprecationWarning
#export PYTHONWARNINGS=d

# Set virtualenv facilities
export WORKON_HOME=$HOME/virtualenvs
export VIRTUALENVWRAPPER_HOOK_DIR=$HOME/.virtualenv
# Use default Python. VIRTUALENVWRAPPER_PYTHON doesn't seems to be used by virtualenvwrapper, so
# force it through venv's args.
# export VIRTUALENVWRAPPER_PYTHON=`which python`
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS="--python=$(which python)"

# Load shell helpers
# source virtualenvwrapper.sh
# source ~/.autoenv/activate.sh

eval "$(pip2.7 completion --zsh)"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
# [ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# Extract most know archives with one command
extract () {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2)  tar xjf "$1"    ;;
            *.tar.gz)   tar xzf "$1"    ;;
            *.bz2)      bunzip2 "$1"    ;;
            *.rar)      unrar e "$1"    ;;
            *.gz)       gunzip "$1"     ;;
            *.tar)      tar xf "$1"     ;;
            *.tbz2)     tar xjf "$1"    ;;
            *.tgz)      tar xzf "$1"    ;;
            *.xz)       tar xJf "$1"    ;;
            *.zip)      unzip "$1"      ;;
            *.Z)        uncompress "$1" ;;
            *.7z)       7z x "$1"       ;;
            *.xar)      xar -xvf "$1"   ;;
            *.pkg)      xar -xvf "$1"   ;;
            *)          echo "'$1' cannot be extracted via extract()";;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Distribution-specific commands
if $IS_MACOS; then

    # Opens current directory in apps
    alias f='open -a Finder ./'

    # Replace netstat command on macOS to find ports used by apps
    alias netstat="sudo lsof -i -P"

    # Add tab completion for `defaults read|write NSGlobalDomain`
    # You could just use `-g` instead, but I like being explicit
    # complete -W "NSGlobalDomain" defaults

    # Lock the screen
    alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

    # Link pinentry and GPG agent together
    # if test -f $HOME/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
    #     source $HOME/.gnupg/.gpg-agent-info
    #     export GPG_AGENT_INFO
    # else
    #     eval $(gpg-agent --daemon --write-env-file $HOME/.gnupg/.gpg-agent-info)
    # fi

fi

# User specific environment and startup programs
PATH=$HOME/bin:$HOME/.local/bin:$PATH
export PATH

# pyspark
export PYSPARK_SUBMIT_ARGS="pyspark-shell"
if $IS_MACOS; then
  export SPARK_HOME=/usr/local/Cellar/apache-spark/2.1.0/libexec
else
  export SPARK_HOME=/usr/lib/spark
  export HADOOP_USER_NAME="$USER"
  export PYSPARK_PYTHON=/usr/bin/python2.7
fi

export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/build:$PYTHONPATH
export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.9-src.zip:$PYTHONPATH
export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH

alias htxt='snakebite text'
alias hls='snakebite ls -h'
alias hdu='snakebite du -h'
alias hatxt='hadoop fs -text'

alias epyspark2='SPARK_HOME=$HOME/spark-2.1.0-bin-hadoop2.6/ PYTHONPATH="$SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:."'
alias epyspark2_cl='SPARK_HOME=/usr/lib/spark2/ PYTHONPATH="$SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:."'

source ~/.bash_profile.d/*.sh