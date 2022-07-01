### This is the ~/.bashrc file of Tim Schaefer. Feel free to use/extend it.

## Note that the .bashrc file is also executed when running sub shells, so put stuff like aliases in here.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

### Some useful aliases
alias la="ls -a"       # includes hidden dot files
alias ll="ls -l"       # display details
alias lt="ls -ltr"     # sort by modification date, inverse (good for looking at your downloads dir: finds last files you downloaded)
alias h="history"
alias ipy="ipython"    # seriously.
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


### Set a useful shell prompt (displays '<user>@<host>:<workdir> $' in front of the command line):
export PS1="[\\u@\\h:\\w] $ "

### A custom directory into which you commonly install software, and which should be searched for software.
### This is typically in your HOME, but on a cluster, it could be a shared directory which contains software.
MY_SOFTWARE_DIR="${HOME}/software"                        # private software in your home
#MY_SOFTWARE_DIR="/work/projects/Project00828/software"    # shared software dir on cluster

### Set environment for FreeSurfer neuro imaging software
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    MY_FREESURFER_DIR="${MY_SOFTWARE_DIR}/freesurfer"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    MY_FREESURFER_DIR="/Applications/freesurfer"
fi

if [ -d "$MY_FREESURFER_DIR" ]; then
    export FREESURFER_HOME="$MY_FREESURFER_DIR"
    source $FREESURFER_HOME/SetUpFreeSurfer.sh
fi

MY_FS_QA_TOOLS_DIR="${MY_SOFTWARE_DIR}/QAtools_v1.2"
if [ -d "$FS_QA_TOOLS_DIR" ]; then
    export QA_TOOLS="$MY_FS_QA_TOOLS_DIR"
fi

### Add PALM to path if it is installed
MY_PALM_DIR="${MY_SOFTWARE_DIR}/palm-alpha111"
if [ -d "$MY_PALM_DIR" ]; then
    export PATH="${PATH}:${MY_PALM_DIR}"
fi

### Set environment for FSL
FSLDIR="/usr/local/fsl"
ALTERNATIVE_FSLDIR="${MY_SOFTWARE_DIR}/fsl"
if [ -d "$FSLDIR" ]; then
    . ${FSLDIR}/etc/fslconf/fsl.sh
    PATH=${FSLDIR}/bin:${PATH}
    export FSLDIR PATH
elif [ -d "$ALTERNATIVE_FSLDIR" ]; then
    FSLDIR="$ALTERNATIVE_FSLDIR"
    . ${FSLDIR}/etc/fslconf/fsl.sh
    PATH=${FSLDIR}/bin:${PATH}
    export FSLDIR PATH
fi

### Check for conda (a package manager and environment management system for Python. Annoying but better than nothing on MacOS).
### Note that the following command does NOT activate conda: you still use your system python by default. You still have to run 'conda activate' to start conda.
CONDA_DIR="${HOME}/anaconda2"
CONDA_BIN_DIR="${CONDA_DIR}/bin"
if [ -d "${CONDA_BIN_DIR}" ]; then
    #export PATH="${PATH}:${CONDA_BIN_DIR}"     # This was how it was done before conda 4.4, and this DID automatically activated conda, which is why I did NOT want it.
    source ${CONDA_DIR}/etc/profile.d/conda.sh  # This is the new way since 4.4, thid will NOT activate the base conda environment. Run 'conda activate' explicitely to do that.

    if [[ "$OSTYPE" == "darwin"* ]]; then
        conda activate              # activate conda by default under MacOS. Their system python is more or less unusable, so I prefer conda in this case.
    fi
fi

### Add the matlab binary location to your path. This is required for some FreeSurfer tools that rely on Matlab.
MATLAB_INSTALL_DIR="/Applications/MATLAB_R2018a.app"
if [ -d "${MATLAB_INSTALL_DIR}" ]; then
    export MATLABPATH=${MATLAB_INSTALL_DIR}
    PATH="${PATH}:${MATLABPATH}/bin"
fi

### Locale settings. Activate these (remove comments) if your system does not set these correctly by default.
### (This is the case on some cluster computers we use.)
#export LANG=en_US.utf8
#export LC_CTYPE=en_US.utf8
#export LC_ALL=en_US.utf8
