### This is the ~/.bash_profile file of Tim Schaefer. Feel free to use/extend it.

# Note: This file is read by login shells (as opposed to sub shells which are spawned when you use screen or whatever: they inherit some stuff that is set here, but only read ~/.bashrc).
# As environment variables are passed on to sub shells, you should set them in here instead of in your ~/.bashrc. Doing so prevents having them overriden (if you changed them during an interactive session) when spawning a sub shell.

### Read bashrc for stuff like aliases
if [ -f "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
fi


### Color some commands
export TERM=xterm-color
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33'


### Add ~/bin/ to path.
export PATH="$PATH:~/bin"

### Run in interactive mode only. See https://www.gnu.org/software/bash/manual/html_node/Interactive-Shells.html for info on what interactive means.
### Essentially, this ensures that scripts and stuff like scp work as expected.
if [ -n "$PS1" ]; then

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
fi
