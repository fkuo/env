# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="fred"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git autojump)

[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh
source $ZSH/oh-my-zsh.sh
[[ -s /home/dev/.nvm/nvm.sh ]] && . /home/dev/.nvm/nvm.sh # This loads NVM

os=$(uname -s)
if [ "$os" = "SunOS" ]; then
  alias vi="vim -O"
  workspace="$HOME"
elif [ "$os" = "Darwin" ]; then
  workspace="$HOME/workspace"
  alias vi="/Applications/MacVim.App/Contents/MacOS/Vim -O"
  PATH=/opt/local/libexec/gnubin/:$PATH # if macports is installed
fi

# Customize to your needs...
export PATH=${workspace}/bin:${workspace}/node-manta/bin:$PATH

# ls options
ls --version | grep GNU >/dev/null 2>&1 # check for GNU ls
if [ $? -eq 0 ]; then
  alias ls="ls --color=auto --group-directories-first"
else
  alias ls="ls -G" # assume BSD
fi

# date options
date --version | grep GNU >/dev/null 2>&1 # check for GNU date
if [ $? -eq 0 ]; then
  alias date="date --rfc-3339=seconds"
fi

# msu p or msu f
function msu()
{
  if [ "$1" = "p" ]; then
      export MANTA_URL="https://us-east.manta.joyent.com"
      export MANTA_USER="poseidon"
      export MANTA_KEY_ID="f0:22:7b:02:20:26:15:de:22:84:e5:d3:54:ea:b1:8d"
      echo "poseidon"
  elif [ "$1" = "f" ]; then
      export MANTA_URL="https://us-east.manta.joyent.com"
      export MANTA_KEY_ID="e3:4d:9b:26:bd:ef:a1:db:43:ae:4b:f7:bc:69:a7:24"
      export MANTA_USER="fredkuo"
      echo "fredkuo"
  fi
}
export -f msu >/dev/null

export MANTA_URL="https://us-east.manta.joyent.com"
export MANTA_KEY_ID="e3:4d:9b:26:bd:ef:a1:db:43:ae:4b:f7:bc:69:a7:24"
export MANTA_USER="fredkuo"

# Disable ctrl+s
stty -ixon

#~/bin/fix-ntp.sh > /dev/null 2>&1
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
