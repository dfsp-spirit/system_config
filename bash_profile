### This is the ~/.bash_profile file of Tim Schaefer. Feel free to use/extend it.

# Note: This file is read by login shells (as opposed to sub shells which are spawned when you use screen or whatever: they inherit some stuff that is set here, but only read ~/.bashrc).
# As environment variables are passed on to sub shells, you could set them in here instead of in your ~/.bashrc. Doing so prevents having them overriden (if you changed them during an interactive session) when spawning a sub shell.
# I don't do that anymore though, since under Linux, terminals started under X11 do not source bash_profile, and I need my env vars in those shells as well (so I have them in bashrc).

### Read bashrc for stuff like aliases
if [ -f "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
fi


date
if [ -x /usr/games/fortune ]; then
    /usr/games/fortune -s
fi
