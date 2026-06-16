current_folder=$(dirname "$(readlink -f "$BASH_SOURCE")")
[ -f $current_folder/.my_bash_prompt.sh ] && source $current_folder/.my_bash_prompt.sh
[ -f $current_folder/my_bash_prompt.sh ] && source $current_folder/my_bash_prompt.sh

#
# exports
export LESS=-FXR
export -n LESSCLOSE
export LESSOPEN="| ~/scripts/lessfilter.sh %s"

# setting the default editor to vi
export EDITOR=vi
export VISUAL=vi

# create a personal tmp folder
mkdir -p $HOME/tmp
export tmp=$HOME/tmp

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#######
#


#
# aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lg=lazygit
alias rs="rsync -avz -e ssh"
alias v="vim.tiny -u NONE -N -c 'set noswapfile undolevels=-1 nu'"
alias lessno="less --no-lessopen"
#######
#


# display a one-time message
if [[ -f $HOME/.messages ]]; then
  echo
  echo "************** messages **************"
  cat $HOME/.messages
  rm $HOME/.messages
fi

folders_to_path=(
  "/usr/local/go/bin"
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/Android/sdk/cmdline-tools/latest/bin"
)
for ftp in ${folders_to_path[@]}; do
  if [[ -d $ftp ]]; then
    PATH=$ftp:$PATH
  else
    echo "warning: $ftp does not exist, skipping"
  fi
done

[ -f "/usr/libexec/java_home" ]    && export JAVA_HOME=$(/usr/libexec/java_home)
[ -d "$HOME/Android/sdk" ]         && export ANDROID_HOME="$HOME/Android/sdk"

