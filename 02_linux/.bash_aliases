# Reloads the bashrc file
alias bashreload="source ~/.bashrc && echo Bash config reloaded"

# Open nano and make backup of original file. Useful for config files and things you don't want to edit the original
function nanobk() {
    echo "You are making a copy of $1 before you open it. Press enter to continue."
    read nul
    cp $1 $1.bak
    nano $1
}


function vibk() {
    echo "You are making a copy of $1 before you open it. Press enter to continue."
    read nul
    cp $1 $1.bak
    vi $1
}

# Clear DNS Cache

# Still need testing on this one

alias flushdns="sudo /etc/init.d/dns-clean restart && echo DNS cache flushed"


# Get IPs associated with this site

# Work to dynamically list all interfaces. Will add later. 
# Currently only uses the hardcoded interface names

function myip()
{
    extIp=$(dig +short myip.opendns.com @resolver1.opendns.com)

    printf "Wireless IP: "
    MY_IP=$(/sbin/ifconfig wlp4s0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}


    printf "Wired IP: "
    MY_IP=$(/sbin/ifconfig enp0s25 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}

    echo ""
    echo "WAN IP: $extIp"

}


# Syntax: "repeat [X] [command]"
function repeat()      
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}


alias ..="cd .."


if [ $UID -ne 0 ]; then
    alias reboot="sudo reboot"
    alias update="sudo apt-get update && sudo apt-get upgrade"
    alias apt-get="sudo apt-get"
fi


#search

alias qfind="find . -name "
ff() { /usr/bin/find . -name "$@" ; }
ffs() { /usr/bin/find . -name "$@"'*' ; }
ffe() { /usr/bin/find . -name '*'"$@" ; }





alias h="history"
alias j="jobs -l"

alias root="sudo -i"
alias su="sudo -i"

alias svi="sudo vi"

alias path="echo -e ${PATH//:/\\n}"


#Get system memory and etc ...

alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

alias cpuinfo='lscpu'
alias gpuinfo='grep -i --color memory /var/log/Xorg.0.log'

# Make some of the file manipulation programs verbose
alias mv="mv -v"
alias rm="rm -vi"
alias cp="cp -v"

# Prints disk usage in human readable form
alias d="du -sh"

# Clear the screen of your clutter
alias c="clear"
alias cl="clear;ls;pwd"
alias cls="clear"

# GREP Motifications
alias grep="grep --color"
alias grepp="grep -P --color"


# Json tools (pipe unformatted to these to nicely format the JSON)
alias json="python -m json.tool"
alias jsonf="python -m json.tool"

# Edit shortcuts for config files
alias sshconfig="${EDITOR:-nano} ~/.ssh/config"
alias bashrc="${EDITOR:-nano} +120 ~/.bashrc && source ~/.bashrc && echo Bash config edited and reloaded."

# SSH helper
alias sshclear="rm ~/.ssh/multiplex/* -f && echo SSH connection cache cleared;"
alias sshlist="echo Currently open ssh connections && echo && l ~/.ssh/multiplex/"

