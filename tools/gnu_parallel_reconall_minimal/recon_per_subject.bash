#!/bin/bash
# recon_per_subject.bash -- run recon-all for subject
#
# Note that you can run this from `run_reconall_parallel_wrapper.bash` to apply it to several subjects in parallel.
# You should not execute this script directly (though you can if you want to run for a single subject only).

APPTAG="[RECON_PER_SUBJECT]"

if [ -z "$1" ]; then
  echo "$APPTAG ERROR: Arguments missing."
  echo "$APPTAG Usage: $0 <subject>"
  echo "$APPTAG Note that the environment variable SUBJECTS_DIR must also be set correctly."
  exit 1
else
  SUBJECT="$1"
fi

##### Check some basic stuff first. If these checks fail, there is no need to start recon-all.

if [ -z "${SUBJECTS_DIR}" ]; then
  echo "$APPTAG ERROR: Environment variable SUBJECTS_DIR not set. Exiting."
  exit 1
fi

if [ ! -d "${SUBJECTS_DIR}" ]; then
  echo "$APPTAG ERROR: Environment variable SUBJECTS_DIR points to '${SUBJECTS_DIR}' but that directory does NOT exist. Exiting."
  exit 1
fi


if [ ! -d "${SUBJECTS_DIR}/${SUBJECT}" ]; then
  echo "$APPTAG ERROR: Directory for subject '${SUBJECT}' not found in SUBJECTS_DIR '${SUBJECTS_DIR}'. Exiting."
  exit 1
fi

## Looks fine, let's just try

recon-all -autorecon-all -sd ${SUBJECTS_DIR} -subjid ${SUBJECT} -no-isrunning -qcache
