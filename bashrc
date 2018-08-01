### This is the ~/.bashrc file of Tim Schaefer. Feel free to use/extend it.

## Note that the .bashrc file is also executed when running sub shells, so put stuff like aliases in here.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

### Some useful aliases
alias la="ls -a"       # includes hidden dot files
alias ll="ls -l"       # display details
alias lt="ls -ltr"     # sort by modification date, inverse (good for looking at your downloads dir: finds last files you downloaded)
alias h="history"
alias d="date"
alias grep="grep --color"

### Can't do this on MacOS
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias ls='ls --color=auto'
fi

### Color some commands
export TERM=xterm-color
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33'


### Add ~/bin/ to path.
export PATH="$PATH:~/bin"


### set a useful shell prompt (displays '<user>@<host>:<workdir> $' in front of the command line):
export PS1="[\\u@\\h:\\w] $ "

### Set environment for FreeSurfer neuro imaging software
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    MY_FREESURFER_DIR="${HOME}/software/freesurfer"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    MY_FREESURFER_DIR="/Applications/freesurfer"
fi

if [ -d "$MY_FREESURFER_DIR" ]; then
    export FREESURFER_HOME="$MY_FREESURFER_DIR"
    source $FREESURFER_HOME/SetUpFreeSurfer.sh
fi

### Add PALM to path if it is installed
MY_PALM_DIR="${HOME}/software/palm-alpha111"
if [ -d "$MY_PALM_DIR" ]; then
    export PATH="${PATH}:${MY_PALM_DIR}"
fi

# Set environment for FSL
FSLDIR="/usr/local/fsl"
if [ -d "$FSLDIR" ]; then
    . ${FSLDIR}/etc/fslconf/fsl.sh
    PATH=${FSLDIR}/bin:${PATH}
    export FSLDIR PATH
fi

# Check for conda (a package manager and environment management system for Python, only needed for nipy / PySurfer).
CONDA_DIR="${HOME}/anaconda2/bin"
if [ -d "$CONDA_DIR" ]; then
    export PATH="${PATH}:${CONDA_DIR}"
fi
