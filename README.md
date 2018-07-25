# system_config
My system configuration (bash_profile, bashrc, vimrc, ...) including my setup for popular neuroimaging software. I use the `bash` shell under both GNU/Linux and MacOS, and I do my best to keep this setup consistent between these two operating systems.

## About

These are my personal config files to setup my environment in the bash shell under Linux and MacOS. Whenever I use or install a new machine, or get a user account on some new server, I grab this from here. They include the setup for neuroimaging software like FreeSurfer and FSL. This setup doesn't do any magic:

* configure the shell prompt to `user@host: workdir`
* add stuff the the `$PATH` environment variable, including general stuff like `~/bin/` but also my neuroimaging software installations (it won't hurt if you don't have them, it checks for them first).
* colour some shell output
* add my aliases
* configure the `vim` editor with syntax highlighting, line number display, the solarized colour scheme, ...
* more stuff I forgot

This setup is not *really* intended to be used by anybody else, but please feel free to do so.

The neuroimaging software that I check for:
* FSL (FMRIB Software Library, see https://fsl.fmrib.ox.ac.uk/fsl/)
* FreeSurfer (see https://surfer.nmr.mgh.harvard.edu/)
* PALM (Permutation Analysis of Linear Models, see https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/PALM)
* Anaconda2 (for PySurfer etc, see https://anaconda.org/anaconda/python)


## Usage

This is a collection of system configuration files and a script, `install_sysconfig.bash`, that copies all of these files into place.

WARNING: The script overwrites your current files and does NOT make a backup (this repo is my backup).

It is very likely that you will at least have to adapt the installation paths of your neuroimaging software in the `bash_profile` file. I check for my installation paths and defaults if available, but as you may have installed to a different location, you have to adapt the paths.

So what you should do is:
1) Download/clone the repo and have a look at the files (especially the paths in `bash_profile`) and adapt stuff to your needs.
    * To download, click the green `Clone or download` button near the top of this page, then click `Download ZIP`.
2) Make a backup of your current config files.
3) Run the install script from within its directory: `./install_sysconfig.bash`

If you only want a minimum setup, you can omit step 3 and copy the files you want manually. To use only my basic bash shell setup (and not the vim and ssh config files, etc), do:

```bash
   cp bash_profile ~/.bash_profile
   cp bashrc ~/.bashrc
```


## Recommended usage

If you use Github, I would recommend forking this repo and using/maintaining/updating your own copy in the future.

## External tools

This repo contains some external tools created by others and software which does NOT fall under the license of the repo.

* `tools/solarized/solarized.vim`: solarized colour scheme by [Ethan Schoonover](http://ethanschoonover.com/solarized), implementation for the vim editor by [altercation](https://github.com/altercation/vim-colors-solarized)
* `bin/obj2surf` and `bin/surf2obj`: shell scripts by [Anderson M. Winkler](https://brainder.org/) to convert surface files (meshes) between the obj and FreeSurfer ASCII formats
