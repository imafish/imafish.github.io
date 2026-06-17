#!/bin/bash
 
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

current_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
 
if [[ -f "$current_dir/my_icon.sh" ]]; then
  . "$current_dir/my_icon.sh"
fi
if [[ -f "$current_dir/.my_icon.sh" ]]; then
  . "$current_dir/.my_icon.sh"
fi
if [[ -z "$PS_ICON" ]]; then
  export PS_ICON="🐾"
fi

export PS_POST="\e[0;37m\n"
export PS0='$(printf "%s" ${EPOCHREALTIME/./} >"$HOME/.tmp/timer.$$")'

if [ "$color_prompt" = yes ]; then
    export PS_PRE="\e[32;1m▼ \e[22m$PS_ICON \e[0;22;37;2m ${debian_chroot:+($debian_chroot)}\u@\h:\e[22;37m \w"
else
    export PS_PRE="▼ ${debian_chroot:+($debian_chroot)}\u@\h:\w $(__git_ps1 2>/dev/null)"
fi

function prompt_runtime {
	# Calculate the approximate runtime of the previous command
	# Uses bash 5.0's EPOCHREALTIME
	local starttime endtime duration days hours minutes seconds microseconds nanoseconds str
	[ ! -r $HOME/.tmp/timer.$$ ] && printf "[0.000s]" && return
	read starttime < $HOME/.tmp/timer.$$ 2>/dev/null || true
	endtime=${EPOCHREALTIME/./}
	starttime=${starttime/./}
	duration=$((endtime - starttime))
	days=$((duration/1000000/60/60/24))
	hours=$((duration/1000000/60/60%24))
	minutes=$((duration/1000000/60%60))
	seconds=$((duration/1000000%60))
	nanoseconds=$((duration-days*1000000*60*60*24-hours*1000000*60*60-minutes*1000000*60-seconds*1000000))
	nanoseconds=$(printf "%.6d" ${nanoseconds})
	microseconds=${nanoseconds:0:3}
	# Shorten our string as much as possible
	[ "$days" = "0" ] && days= || days="${days}d "
	[ "$hours" = "0" ] && hours= || hours="${hours}h "
	[ "$minutes" = "0" ] && minutes= || minutes="${minutes}m "
	str="${days}${hours}${minutes}${seconds}.${microseconds}s"
	printf "[%s]" "$str"
}
 
function set_prompt {
  local exit_code=$?
  local git_ps1="\e[0;33m$(__git_ps1 2>/dev/null)"
  local date_prompt="\e[36;2m [$(date +'%Y-%m-%d %H:%M:%S')]"
  local last_command_prompt=""
  local python_venv_prompt=""
  local runtime_prompt=""
  local runtime_prompt_raw=$(prompt_runtime)

  if [[ -n "$runtime_prompt_raw" ]]; then
    runtime_prompt=" \e[0;36m$runtime_prompt_raw${NC}"
  fi
 
  if [ $exit_code -ne 0 ]; then
    local last_command=$(history 1 | sed 's/^[ ]*[0-9]*[ ]*//;s/[&;]*$//;s/^ *//;s/ *$//;s/$(/$.(/')
    if [ ${#last_command} -gt 20 ]; then
      last_command="${last_command:0:16} ..."
    fi
    last_command_prompt=" \e[0;31m✖ $exit_code\e[2m[\e[37m$last_command\e[31m]" 
  fi
  if [[ -n "$VIRTUAL_ENV_PROMPT" ]]; then
    python_venv_prompt="\e[0;35m $VIRTUAL_ENV_PROMPT "
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    python_venv_prompt="\e[0;35m (`basename \"${VIRTUAL_ENV}\"`) "
  fi

  local qnx_gdb_prompt=""
  if [[ -n "$QNX_HOST" && -n "$QNX_TARGET" ]]; then
    last_host=$(basename "$QNX_HOST")
    last_target=$(basename "$QNX_TARGET")
    qnx_version="?"
    if [[ "$QNX_TARGET" == *"qnx7"* ]]; then
      qnx_version="qnx7"
    elif [[ "$QNX_TARGET" == *"qnx8"* ]]; then
      qnx_version="qnx8"
    fi
    qnx_gdb_prompt="${DARK_GREEN} GDB:${qnx_version}:{${last_host}/${last_target}}${NC}"
  fi

  PS1="${PS_PRE}${date_prompt}${runtime_prompt}${git_ps1}${python_venv_prompt}${qnx_gdb_prompt}${last_command_prompt}${PS_POST}"
}

PROMPT_COMMAND=set_prompt
 
unset color_prompt force_color_prompt
 
# show avatar #ubuntu_scripts#
if [ `tput colors` -gt 255 ]; then
  if [[ -f "$current_dir/avatar_256color.txt" ]]; then
    cat "$current_dir/avatar_256color.txt"
    echo
  elif [[ -f "$current_dir/.avatar_256color.txt" ]]; then
    cat "$current_dir/.avatar_256color.txt"
    echo
  fi
else
  if [[ -f "$current_dir/avatar_8color.txt" ]]; then
    cat "$current_dir/avatar_8color.txt"
    echo
  elif [[ -f "$current_dir/.avatar_8color.txt" ]]; then
    cat "$current_dir/.avatar_8color.txt"
    echo
  fi
fi
 
[[ -d "/usr/games" ]] && PATH="/usr/games:$PATH"
fortune
echo

