#!/bin/bash
# run_reconall_parallel_wrapper.bash -- run stuff in parallel over a number of subjects
#
# Written by Tim Schaefer, http://rcmd.org/ts/
#
# You must adapt the settings below for this script to work.
# This script is for the BASH shell, so are the example commands.
#
# I would suggest to run it from within a GNU screen session. That way it will
# continue running in the background if you lose connection to the host (when
# stated via ssh) or accidentely reboot your machine or close the terminal window.
#
# #####  UPDATE (2022-03-21): #####
# I decided to make the full version of all my FreeSurfer parallel scripts for 
# various tasks publicly available at: 
#
#      https://github.com/dfsp-spirit/freesurfer_parallel_scripts/
#
# You should use the script cross-sectional/preproc_reconall_parallel.bash from that repo
# instead of this script (and also check out the other scripts in there).
#
# There is nothing wrong with using the one from this repo, but the other one can do more.
#
# ##### END OF UPDATE MESSAGE #####
#
#
# I -- Expected contents of your $SUBJECTS_DIR (what your data should look like before running this script)
#
#   This script expects that you have a SUBJECTS_DIR full of NIFTI-files, each named after the subject ID.
#   E.g.: $SUBJECTS_DIR/subject1.nii, $SUBJECTS_DIR/subject2.nii, ...
#
#   You need to create the directory structure for FreeSurfer in the directory based on the NIFTI
#   files. To do so, you can use this commands:
#
#          cd $SUBJECTS_DIR
#          ls *.nii | parallel -S 4/: "recon-all -sd . -i {} -s {.}"
#
#   If you have nii.gz files of ngz files (gzipped NIFTI), you will have to extract them first or adapt the
#   commands below. To extract them, you can run (in BASH):
#
#          cd $SUBJECTS_DIR
#          for f in *.gz; do gunzip "$f"; done
#
# II -- Detailed script usage instructions:
#
# 1) Set your FreeSurfer SUBJECTS_DIR to where your data is.
#           Hint: If your data is in '/Volumes/data/study1', run `export SUBJECTS_DIR=/Volumes/data/study1`.
# 2) Download/copy the 2 scripts into a directory of your choice and make sure they are executable.
#           Hint: To make a script called 'script.bash' executable, run `chmod +x script.bash`.
# 3) Make sure you have configured the subjects you want to use (setting 'SUBJECTS' below).
#
# 4) From any directory, run this wrapper script. E.g., :
#               cd $SUBJECTS_DIR
#               /Volumes/scripts/gnu_parallel_reconall_minimal/run_reconall_parallel_wrapper.bash
#

APPTAG="[RUN_RECONALL_PAR]"

##### General settings - adapt these to your needs #####

# NUM_CONSECUTIVE_JOBS: Number of consecutive GNU Parallel jobs. Note that 0 for 'as many as possible'. Maybe set something
# a little bit less than the number of cores of your machine if you want to do something else while it runs.
# See 'man parallel' for details. Under Linux, run `nproc` to see how many you have.
NUM_CONSECUTIVE_JOBS=0

## SUBJECTS: a list of the subjects. You can put as many as you want, and at each timepoint, NUM_CONSECUTIVE_JOBS of them will be processed in parallel. A directory with the subject name must exist under SUBJECTS_DIR for each subject.
SUBJECTS="subject1 subject2 subject3 subject4 subject5 subject6 subject7 subject8 subject9 subject10 subject11 subject12 subject13 subject14 subject15 subject16"

# Or alternatively, if you have all subjects in a text file called 'subjects.txt' with one subject per line, you could read them from this file like this here instead:
#                     Hint: Such a 'subjects.txt' file can be created easily by changing into the SUBJECTS_DIR and then running `ls -1 > subjects.txt`. Then you have edit the file in a text editor to remove some unwanted entries (like the last line, which will list the file itself). Maybe others if you have more stuff in that directory than the subjects you want.
# SUBJECTS=$(cat "subjects.txt" | tr '\n' ' ')
###### End of settings #####

# You do not need to change this if you followed the instructions above. It tells this wrapper script where to find the other script (in the same dir).
EXEC_PATH_OF_THIS_SCRIPT=$(dirname $0)
PER_SUBJECT_SCRIPT="${EXEC_PATH_OF_THIS_SCRIPT}/recon_per_subject.bash"


NUM_SUBJECTS=$(echo ${SUBJECTS} | wc -w  | tr -d '[:space:]')
echo "${APPTAG} Running in parallel for $NUM_SUBJECTS subjects, using $NUM_CONSECUTIVE_JOBS CPU cores."



## Just to be sure: check some essential stuff

# SUBJECTS_DIR must be set
if [ -z "${SUBJECTS_DIR}" ]; then
    echo "${APPTAG} ERROR: Environment variable SUBJECTS_DIR not set. Exiting."
    exit 1
fi

# The inner script must exist and be executable
if [ ! -x "${PER_SUBJECT_SCRIPT}" ]; then
    echo "${APPTAG} ERROR: Inner script not found at configured path '${PER_SUBJECT_SCRIPT}', or it is not executable. Check path and/or run 'chmod +x <file>' on it to make it executable. Exiting."
    exit
fi

DATE_TAG=$(date '+%Y-%m-%d_%H-%M-%S')
echo ${SUBJECTS} | tr ' ' '\n' | parallel --jobs ${NUM_CONSECUTIVE_JOBS} --workdir . --joblog logfile_parallel_run_${DATE_TAG}.txt "${PER_SUBJECT_SCRIPT} {}"
