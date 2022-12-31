#!/bin/bash
## grid.bash -- Generate a markdown overview document from all images in the current directory. Requires pandoc for the (optional) final conversion to HTML.
##
## Written by Tim Schäfer (https://rcmd.org/ts/), 2018-07-21.
## This is free software, released under the MIT License (see https://opensource.org/licenses/MIT)
##
## Note: The latest version is available at https://github.com/dfsp-spirit/shell-tools
##
## Usage: Place this in some directory on your $PATH (a typical directory is ~/bin/ I guess).
##        Then call it in the directory where you want the overview gallery to be created. No need for command line arguments, but you can use '--help' to see optional ones.

APPTAG="[GRID]"                  # Just an arbitrary tag used in all output of this script to stdout (so you can tell what output came from this script)
INPUT_IMAGE_FILE_EXTENSION="png"
OUTPUT_FILE_NO_EXT="image_overview"

DIR_NAME="${PWD##*/}"                                     # Get name of current directory (for /home/ts/projects/project_3, this gives project_3)
TITLE=$(echo "${DIR_NAME}" | tr '-' ' ' | tr '_' ' ')     # Use directory name as a guess for the title (with underscores and dashes replaced by spaces)

echo "$APPTAG +++ GRID -- GeneRate Image Document here (run with '--help' for more info) +++"

if [ -n "$1" ]; then
    if [ "$1" = "--help" -o "$1" = "-h" ]; then
        echo "$APPTAG GRID generates a markdown overview document from all images in the current directory. If available, uses 'pandoc' to convert it to more formats."
        echo "$APPTAG Usage: $0 [<img_file_ext> [<outfile_bn> [--append]]]"
        echo "$APPTAG    <img_file_ext>: The file extension of images that should be included. Example: 'jpg'. Defaults to 'png' if omitted."
        echo "$APPTAG    <outfile_bn>: The base name (i.e., name without file extension) of the output gallery file. Example: 'my_image_gallery'. Defaults to 'image_overview' if omitted."
        echo "$APPTAG    --append or -a: Set append mode. Useful if you want to append to an existing gallery (you can set another file extension!). Output file must exuist in this mode."
        echo "$APPTAG Examples: $0 jpg project_data"
        echo "$APPTAG           $0 png project_data --append"
        exit 0
    fi
    INPUT_IMAGE_FILE_EXTENSION="$1"
fi

if [ -n "$2" ]; then
    OUTPUT_FILE_NO_EXT="$2"
    TITLE=$(echo "$2" | tr '-' ' ' | tr '_' ' ')                     # If the user supplied a file name, that may be an even better guess for the title (with underscores and dashes replaced by spaces)
fi

APPEND_MODE="NO"
if [ "$3" = "--append" -o "$3" = "-a" ]; then
    APPEND_MODE="YES"
    echo "$APPTAG Using append mode."
fi

OUTPUT_FILE_MARKDOWN="${OUTPUT_FILE_NO_EXT}.md"
OUTPUT_FILE_HTML="${OUTPUT_FILE_NO_EXT}.html"

##### Generate the markdown file #####

## Clear file and generate header (unless in append mode)
if [ "${APPEND_MODE}" = "NO" ]; then
  echo "# ${TITLE}" > "${OUTPUT_FILE_MARKDOWN}"
  echo "" >> "${OUTPUT_FILE_MARKDOWN}"
else
    ## In append mode, the output file has to exist.
    if [ ! -f "${OUTPUT_FILE_MARKDOWN}" ]; then
        echo "$APPTAG ERROR: Append mode requested, but output file '${OUTPUT_FILE_MARKDOWN}' does not exist. Exiting."
        exit 1
    fi
fi

## Generate the headings and add the images

NUM_MATCHED_IMAGE_FILES=$(ls -1 *.${INPUT_IMAGE_FILE_EXTENSION} 2>/dev/null | wc -l)
NUM_MATCHED_IMAGE_FILES=$(echo -e "${NUM_MATCHED_IMAGE_FILES}" | tr -d '[:space:]')    # The 'wc' command is broken under MacOS: it outputs whitespace in addition to the number (><), so we have to remove that.

if [ ${NUM_MATCHED_IMAGE_FILES} -lt 1 ]; then
    echo "$APPTAG ERROR: No image files with image file extension '${INPUT_IMAGE_FILE_EXTENSION}' found in current directory. Your gallery would be empty, not doing anything."
    echo "$APPTAG You can run '$0 --help' to see optional command line arguments which allow you to set a custom file extension."
    exit 1
else
    echo "$APPTAG Found ${NUM_MATCHED_IMAGE_FILES} image files with requested extension '${INPUT_IMAGE_FILE_EXTENSION}' in current directory."
    for IMAGE_FILE in *.${INPUT_IMAGE_FILE_EXTENSION}
    do
        IMAGE_FILE_NO_EXTENSION="${IMAGE_FILE%.*}"
        GUESSED_IMAGE_SECTION_TITLE=$(echo "${IMAGE_FILE_NO_EXTENSION}" | tr '-' ' ' | tr '_' ' ')            # Our guess is the image filename without extension, with underscores and dashes replaced by spaces
        echo "## ${GUESSED_IMAGE_SECTION_TITLE}" >> "${OUTPUT_FILE_MARKDOWN}"
        echo "![](${IMAGE_FILE})" >> "${OUTPUT_FILE_MARKDOWN}"
        echo "" >> "${OUTPUT_FILE_MARKDOWN}"
    done
fi

echo "$APPTAG Markdown output file written to '${OUTPUT_FILE_MARKDOWN}'."

##### Use pandoc to create other formats from the Markdown file #####

## Generate HTML if pandoc is available
PANDOC_PATH=$(which pandoc)
if [ -n "$PANDOC_PATH" ]; then
    echo "$APPTAG Generating HTML format from Markdown file '${OUTPUT_FILE_MARKDOWN}', writing to file '${OUTPUT_FILE_HTML}'."
    pandoc -s --toc -o "${OUTPUT_FILE_HTML}" "${OUTPUT_FILE_MARKDOWN}"
    exit $?
else
    echo "$APPTAG Could not find 'pandoc' in PATH, skipped conversion from Markdown to other formats."
fi
