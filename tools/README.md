# shell-tools
Some handy shell scripts for BASH. I have these in ~/bin/ on all systems I use.

## About

This repo contains several tools. See the individual script headers for more details on what they do.

### grid.bash

Generates an overview Markdown document from all image files in the directory where it is called. If `pandoc` is installed, it uses pandoc to convert the Markdown document to other handy format, e.g., HTML. Very handy if have generated a number of plots and want to discuss them with colleagues but avoid the hassle of searching for the correct ones in a file browser.
i

### recon-all-gnu-paralle-minimal

Scripts illustrating  how to perform structural MRI preprocessing in parallel using the FreeSurfer brain imaging suite on Linux systems, using the simple job scheduler GNU parallel. Forget about this unless you work in computational neuroimaging.

### flactree2mp3

Takes your FLAC music collection, a nested tree of directories containing music files in free lossless audio codec files (e.g., music_flac/bandX/albumY/songZ.flac) and generates a new tree that contains the files in MP3 format (e.g., music_mp3/bandX/albumY/songZ.mp3). This is intended for people who have stored their music in high-quality files, but need to export it for playback on devices which only support MP3 format. Requires ffmpeg (which includes LAME and should be installed on most desktop Linux systems).

## Installation
You can copy all of the into your ~/bin/ directory by running `install.bash`.

## License
All of these scripts are released under very permissive licenses, see the script headers. Just assume MIT if I forgot to put a license.
