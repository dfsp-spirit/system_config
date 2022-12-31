# Shell scripts to run the FreeSurfer recon-all pipeline in parallel

## Outdated directory:

I decided to make the full version of all my [FreeSurfer parallel scripts](https://github.com/dfsp-spirit/freesurfer_parallel_scripts/) for various tasks publicly available. You should use the script [freesurfer_parallel_scripts/cross-sectional/preproc_reconall_parallel.bash](https://github.com/dfsp-spirit/freesurfer_parallel_scripts/blob/main/cross-sectional/preproc_reconall_parallel.bash) instead of the minimal one from this directory.

There is nothing wrong with using the one from this repo, but the other one can do more.

## About

These two scripts serve to run `recon-all` in parallel using the [GNU parallel](https://www.gnu.org/software/parallel/) software.

The parallelization happens on the subject level: there is no speedup for running a single subject,
but on a machine with 24 cores, you can run 24 subjects in parallel at any given time and expect roughly linear speedup.

See the script headers for detailed usage instructions.

## Author and LICENSE

These scripts were written by Tim Schäfer. Do whatever you want with this, just don't blame me. 

If you need a formal license, it is here: http://www.wtfpl.net/
