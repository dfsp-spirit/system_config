### This is the ~/.bashrc file of Tim Schaefer. Feel free to use/extend it.

## Note that the .bashrc file is also executed when running sub shells, so put stuff like aliases (which are not automatically propagated to them) in here.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

### Some useful aliases
alias la="ls -a"       # includes hidden dot files
alias ll="ls -l"       # display details
alias lt="ls -ltr"     # sort by modification date, inverse (good for looking at your downloads dir: finds last files you downloaded)
alias h="history"
alias d="date"
