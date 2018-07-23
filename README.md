# system_config
My system configuration (bash_profile, bashrc, vimrc, ...) including my setup for popular neuroimaging software.

## About

These are my personal config files to setup my environment in the bash shell under Linux and MacOS. Whenever I use or install a new machine, or get a user account on some new server, I grab this from here. They include the setup for neuroimaging software like FreeSurfer and FSL. This setup doesn't do any magic:

* configure the shell prompt to `user@host: workdir`
* add stuff the the `$PATH` environment variable, including general stuff like `~/bin/` but also my neuroimaging software installations (it won't hurt if you don't have them, it checks for them first).
* colour some shell output
* add my aliases
* configure the `vim` editor with syntax highlighting, line number display, the solarized colour scheme, ...
* more stuff I forgot

This setup is not *really* intended to be used by anybody else, but please feel free to do so.


## Usage

This is a collection of system configuration files and a script, `install_sysconfig.bash`, that copies all of these files into place.

WARNING: The script overwrites your current files and does NOT make a backup (this repo is my backup).

It is very likely that you will at least have to adapt the installation paths of your neuroimaging software in the `bash_profile` file. I check for my installation paths (and defaults, if available) of the following software in there:
* FSL (FMRIB Software Library, see https://fsl.fmrib.ox.ac.uk/fsl/)
* FreeSurfer (see https://surfer.nmr.mgh.harvard.edu/)
* PALM (Permutation Analysis of Linear Models, see https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/PALM)
* Anaconda2 (see https://anaconda.org/anaconda/python)

As you may have installed to a different location, you have to adapt the paths.

So what you should do is:
1) Download/clone the repo and have a look at the files (especially the paths in `bash_profile`) and adapt stuff to your needs.
    * To download, click the green `Clone or download` button near the top of this page, then click `Download ZIP`.
2) Make a backup of your current config files.
3) run the `install_sysconfig.bash` script from within its directory


## Recommended usage

If you use Github, I would recommend forking this repo and using/maintaining/updating your own copy in the future.
