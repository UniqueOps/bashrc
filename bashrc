#!/bin/sh
# Casey M. Aliases

# Source Global Definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Declare Bash History Display Format
HISTTIMEFORMAT='%Y/%m/%d - %H:%M:%S - '

# Organize SSH Sessions
ssh() {
  screen -t "$*" -- /usr/bin/ssh -lroot -p1157 $*
}

# Command Aliases
alias mv="mv -v" ;
alias cp="cp -v" ;
alias rm="rm -v" ;
alias ln="ln -v" ;
alias ll="ls -lah" ;
alias yes="no";
alias chmod="chmod -v" ;
alias chown="chown -v" ;

# Server Aliases
alias uniqueops_alpha="ssh alpha.uniqueops.com -lroot -p1157" ;
alias uniqueops_bravo="ssh bravo.uniqueops.com -lroot -p1157" ;
alias 800charitycars="ssh alpha.800charitycars.org -lroot -p1157" ;
alias freecharitycars="ssh alpha.freecharitycars.org -lroot -p1157" ;

# Establish Team Members Credentials
member_first_name="Casey"
member_last_initial="M"
member_initials=$(echo ${member_first_name:0:1}$member_last_name) > /dev/null 2>&1
member_full_name=$(echo $member_first_name $member_last_initial) > /dev/null 2>&1

# Customize Shell Prompt
export PS1='\[\e[0;36m\]\u\[\e[0;37m\]@\[\e[0;37m\]\H\[\e[0;36m\]:\w\[\e[0;0m\] \$ ' ;
sleep 0.5;

# Function - Email Sending Scan
function email_sentfrom(){
  tput rev; echo "Scripts Sending Mail"; tput sgr0
  cat /var/log/exim_mainlog | egrep $(date +%Y-%m-%d)\|$(date +%Y-%m-%d --date='yesterday')\|$(date +%Y-%m-%d --date='2 days ago') | grep sendmail | grep -v root | grep -v Daemon | awk {'print $3'} | cut -d '=' -f2 | sort | uniq -c | sort -nr | head; echo;
    
	tput rev; echo "   [===Authenticated Mail Senders===]"; tput sgr0
  cat /var/log/exim_mainlog | egrep $(date +%Y-%m-%d)\|$(date +%Y-%m-%d --date='yesterday')\|$(date +%Y-%m-%d --date='2 days ago') | egrep dovecot_plain:.*\|dovecot_login:.* -o | awk {'print $1'} | cut -d ':' -f2 | sort | uniq -c | sort -nr | head;
}

# Clear Screen After Import
clear;
