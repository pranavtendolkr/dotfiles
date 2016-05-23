# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
 export LS_OPTIONS='--color=auto'
 eval "`dircolors`"
 alias ls='ls $LS_OPTIONS'
 alias ll='ls $LS_OPTIONS -l'
 alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'



export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoreboth
export HISTIGNORE="&:ls:[bf]g:exit"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."


###WELCOME SCREEN###
 /usr/games/fortune | /usr/games/cowsay
echo -ne "${BLUE}Sysinfo:";uptime ;
#echo -ne "${NC}"; cal ;
echo -ne "${NC}";



extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }


#dirsize - finds directory sizes and lists them for the current directory
dirsize ()
{
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm -rf /tmp/list
}


function exitstatus {
        EXITSTATUS="$?"
	PS1="\[\e[0;36m\][\t] \[\e[1;33m\]\u\["
        if (( "$EXITSTATUS" == "130" )); then
	    PS1=$PS1"${MAGENTA}"
	elif (("$EXITSTATUS" == "1")) || (( ("$EXITSTATUS" >= "128") && ("$EXITSTATUS" <= "255") )); then
	    PS1=$PS1"${RED}"    
	elif (("$EXITSTATUS" == "2")) || (("$EXITSTATUS" == "126")) || (("$EXITSTATUS" == "127")); then
	    PS1=$PS1"${BLUE}"
	elif (("$EXITSTATUS" == "0")); then
	    PS1=$PS1"${NC}"
	else
	    PS1=$PS1"${CYAN}"e
        fi
	PS1=$PS1"\]@\[${NC}\]\h:\[\e[0;36m\]\w\[\e[0m\]\$ "
}

PROMPT_COMMAND=exitstatus



alias lsd="ls -alF | grep /$"

alias free='free -h'
alias df='df -h'
alias h="history|grep "

# This is GOLD for finding out what is taking so much space on your drives!
alias diskspace="du -S | sort -n -r |more"
alias torrent="deluge-console info"
alias mplayer="mplayer -speed 1.28  -msgcolor -msgmodule"

