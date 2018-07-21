# system_config
My system configuration (bash_profile, bashrc, vimrc, ...) including my setup for popular neuroimaging software.

These are my personal config files to setup my environment in the bash shell under Linux and MacOS. They include the setup for neuroimaging software like FreeSurfer, FSL, and PALM. This setup doesn't do any magic:

* configure the shell prompt to `user@host: workdir`
* add stuff the the `$PATH` environment variable, including general stuff like `~/bin/` but also my neuroimaging software installations (it won't hurt if you don't have them, it checks for them first).
* color some shell output
* add my aliases
* configure the `vim` editor with syntax highlighting, line number display, the solarized color scheme, ...
* more stuff I forgot

This setup is not really intended to be used by anybody else. If you want to use it, it is very likely that you will at least have to adapt the installation paths of your neuroimaging software in the `bash_profile` file.
