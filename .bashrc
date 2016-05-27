# =============================================================== #

# set history and size to unlimited, but ignore duplicates, ensure write on terminal close
# Note that you don't need to, and indeed should not, export HISTIGNORE.
# This is a bash internal variable, not an environment variable
HISTCONTROL=erasedups
HISTSIZE=
HISTFILESIZE=
shopt -s histappend
export EDITOR='vim'

#============================================================
#
#  EXTERNAL SOURCES
#
#============================================================

# source in some utility files
[ -f $HOME/.colours ] && source $HOME/.colours


#============================================================
#
#  ALIASES AND FUNCTIONS
#
#============================================================

#-------------------
# Personnal Aliases
#-------------------
alias mkdir='mkdir -p'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias du='du -kh'    # disc usage. Makes a more readable output.

alias vi=vim
alias be='bundle exec '
alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop"
alias pg_restart="pg_ctl -D /usr/local/var/postgres -m i -l /usr/local/var/postgres/server.log restart"

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias lt='ls -ltr'         #  Sort by date, most recent last.

#============================================================
#
#  Git
#
#============================================================

# Aliases - http://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html
alias g='git'
alias gs='git status'
alias save_game='git add . && git commit -m wip'

alias gbr='for k in `git branch|perl -pe s/^..//`;do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1`\\t$k;done|sort -r'
alias git_delete_merged_branches='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias gbgrep="git branch -a | tr -d \* | xargs git grep" # =>  $ git grep_all <regexp>
alias greset='git co master; git fetch -p; git reset --hard origin/master'


#============================================================
#
#  PROMPT
#
#============================================================

find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch)"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty='*'
  else
    git_dirty=''
  fi
}

clean_history() {
  local exit_status=$?
  # If the exit status was 127, the command was not found. Let's remove it from history
  local number=$(history | tail -n 1 | awk '{print $1}')
  if [ -n "$number" ]; then
      if [ $exit_status -eq 127 ] && ([ -z $HISTLASTENTRY ] || [ $HISTLASTENTRY -lt $number ]); then
          history -d $number
      else
          HISTLASTENTRY=$number
      fi
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; clean_history; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
#export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export PS1="\w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
#export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

#============================================================
#
#  PATH
#
#============================================================

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
export PATH="/usr/local/heroku/bin:$PATH" ### Added by the Heroku Toolbelt
export PATH="/usr/local/share/npm/bin:$PATH" # Make Grunt cli work!???
export PATH="./bin:$PATH"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export MAVEN_OPTS="-Djavax.net.ssl.trustStore=/Users/tanya/projects/noths/delivery-settings/keystore.pks -Djavax.net.ssl.trustStorePassword=ptktyfznhfdf1"
export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem
export PATH=~/bin/:$PATH

#------Make sure you don't move it up Tanya!-----
[ -f /usr/local/share/chruby/chruby.sh ] && source /usr/local/share/chruby/chruby.sh
[ -f /usr/local/share/chruby/auto.sh ] && source /usr/local/share/chruby/auto.sh
