#
# ~/.bashrc
#

cd ~

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

if [[ "$PWD" == "/mnt/c/WINDOWS/System32" ]]; then
	cd ~
fi


