#!/bin/bash
#
# flactree2mp3.bash -- copy/convert dirtree ontaining FLAC files to a new tree with equivalent directory structure, but contains the files in MP3 format instead.
#                      In short: convert your music collection to MP3 for playback on stupid non-FLAC compatible devices. This includes devices which can playback
#                                FLAC, but cannot read the tags/metadata (which for me means they cannnot work with FLAC).
#
# Written by Tim Schaefer.
# LICENSE: WTFPL

SOURCE_TREE="$1"
TARGET_TREE="$2"

if [ -z "$TARGET_TREE" ]; then
  echo "USAGE: $0 <source_flace_dir> <target_mp3_dir>"
  exit 0
fi


if [ ! -d "$SOURCE_TREE" ]; then
  echo "ERROR: Source dir '$SOURCE_TREE' does not exist."
  exit 0
fi

if [ ! -d "$TARGET_TREE" ]; then
  echo "ERROR: Target dir '$TARGET_TREE' does not exist."
  exit 0
fi


# Convert all FLAC files in target tree to MP3
cd "${SOURCE_TREE}"
find . -name '*.flac' |
while read filename
do
    dirn=$(dirname "$filename")
    fn=$(basename "$filename")
    echo "$dirn: $fn: $filename"    # ... or any other command using $filename
done
