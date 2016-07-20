# Load ~/.bash_profile ('source ~/.bash_profile’)
#if [ -f ~/.bash_profile ]; then
#  source ~/.bash_profile
#fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
source ~/.secrets

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="clean"
#ZSH_THEME=“bira”

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

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
plugins=(git forklift vagrant compleat docker colored-man colorize hsi z osx)

source $ZSH/oh-my-zsh.sh
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby rbx-3.5.0
#export PATH="$PATH:/Users/sean/.rvm/gems/ruby-2.1.1/bin:/Users/sean/.rvm/gems/ruby-2.1.1@global/bin:/Users/sean/.rvm/rubies/ruby-2.1.1/bin:/Users/sean/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/sean/.rvm/bin"
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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="`$EDITOR` ~/.zshrc"
alias zshsource="source ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias dm="docker-machine"
alias fig="docker-compose"
alias swp='find . -iname "*.sw*"'
#alias vim-git="vim -O $(git status -s | sed "s/??/ ?/g" | cut -d " " -f 3 | xargs)"
#alias vim-swp="vim -O $(swp | sed s/\.swp// | sed 's/^.\///' | sed 's/\/./\//' | xargs)"
alias tail-log="tail -f log/development.log"
alias nib='
  docker run \
    -it \
    --rm \
    -v $(pwd):$(pwd) \
    -w $(pwd) \
    -v $HOME/.docker:/root/.docker:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e "DOCKER_HOST_URL=$DOCKER_HOST" \
    technekes/nib'
alias vim='nvim'

# Docker Machine
function setDockerEnv() {
  docker_machine_default=dinghy
  docker_machine_status=$(docker-machine status $docker_machine_default)
  if [[ "$docker_machine_status" == "Running" ]]
  then
    eval "$(docker-machine env $docker_machine_default)"
  fi
}

function jobscount() {
  local stopped=$(jobs -sp | wc -l)
  local running=$(jobs -rp | wc -l)
  ((running+stopped)) && echo -n "${running}r/${stopped}s "
}

setDockerEnv

export LESS="${LESS} -S"
export EDITOR=vim
export GOPATH=$HOME/code/go
export PATH="$PATH:$GOPATH/bin"
export PATH="/usr/local/sbin:$PATH" # homebrew sbin

source ~/.secrets

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
