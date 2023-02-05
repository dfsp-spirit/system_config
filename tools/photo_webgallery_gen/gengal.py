#!/usr/bin/env python
#
# Create simple HTML chunk that lists all photos in current dir.
# Used to create a simple web gallery from a folder.
#
# WARNING: This script makes assumptions about naming of the thumbnail images, you will have to adapt the code
#          if yours are neamed differently. See regex in 'thumbnail_pattern' below.

import os
import argparse
import glob
import sys
import shutil
import re

def gengal():
    parser = argparse.ArgumentParser(description="Generate gallery HTML.")
    parser.add_argument("-i", "--indir", help="The input dir containing the photos, must exist and be readable.", default=os.path.join(os.getcwd(), "photos"))
    parser.add_argument("-o", "--outdir", help="The output dir to write the HTML file to. Must exist and be writable.", default=os.getcwd())
    parser.add_argument("-p", "--photocaps", help="Readable text file containing one photo caption per line. No captions are assumed if it does not exist.", default="photos_captions.txt")
    parser.add_argument("-f", "--forcepath", help="Force a path prefix for photos.", default=None)
    parser.add_argument("-v", "--verbose", help="Increase output verbosity.", action="store_true")
    args = parser.parse_args()

    indir = args.indir
    outdir = args.outdir
    photos_desc_file = args.photocaps
    verbose = args.verbose
    extension = "jpg"
    outfile = os.path.join(outdir, "gallery.html")
    forcepath = args.forcepath

    imglink_thumb_match="-640x360.jpg" # Filename suffix of thumbnail for image links. Set to None if you dont want thumb links.
                                       # If not none and an image has no thumbnail matching this, it will be ignored completely.

    if not os.path.isdir(indir):
        raise ValueError(f"Directory indir '{indir}' cannot be read.")
    if not os.path.isdir(outdir):
        raise ValueError(f"Directory outdir '{outdir}' cannot be read. Please create.")

    if not os.path.isfile(photos_desc_file):
        print(f"Photocaps file '{photos_desc_file}' not found, not adding captions.")
        photo_caps = {}
    else:
        photo_caps = parse_caps_file(photos_desc_file)
        print(f"Parsed captions for {len(photo_caps)} photos from caps file {photos_desc_file}.")


    img_files = glob.glob(f"{indir}/*.{extension}")

    print(f"Found {len(img_files)} photos with extension '{extension}' in input dir.")
    if verbose:
        for img in img_files:
            print(img)


    out_str = ""
    thumbnail_pattern = re.compile(r"\d{2,4}x\d{2,4}.jpg")
    num_files_used = 0
    num_thumbnails_ign = 0
    for img in img_files:
        if not bool(re.search(thumbnail_pattern, img)): # Ignore the thumbnails, which end with something like '320x480.jpg' or '1024x768.jpg'.
            if verbose:
                    print(f"Using full img file '{img}'.")
            num_files_used += 1
            thumbnail = None
            if imglink_thumb_match is not None:
                img_no_ext = os.path.splitext(img)[0]
                expected_thumbnail_file = f"{img_no_ext + imglink_thumb_match}"
                if os.path.isfile(expected_thumbnail_file):
                    thumbnail = expected_thumbnail_file
                else:
                    print(f"WARNING: No thumbnail with ending '{imglink_thumb_match}' found for full image file {img} (checked for '{expected_thumbnail_file}'). Ignoring file '{img}'.")
                    continue
            out_str += gen_file_html(img, photo_caps, force_path=forcepath, thumbnail=thumbnail)
        else:
            if verbose:
                print(f"Ignoring thumbnail '{img}'.")
            num_thumbnails_ign += 1
    print(f"Used {num_files_used} full image file, ignored {num_thumbnails_ign} thumbnails.")

    with open(outfile, 'w') as f:
        f.write(out_str)
    print(f"Output file '{outfile}' written.")



def parse_caps_file(capsfile):
    """
    Parse a photo captions text file, where each line consists of a file name, followed by a colon ':' and arbitrary text, the caption for the photo.

    Note: The file name should not contain a path, just the file name.
    """
    photo_caps_lines = [line.rstrip() for line in open(photos_desc_file, 'r')]
    caps = {}
    for line_idx, pl in enumerate(photos_caps_lines):
        try:
            parts = pl.split(':', 1)
            photo_file = parts[0]
            caption = parts[1]
            caps[photo_file] = caption
        except Exception as ex:
            print(f"Ignoring line {line_idx + 1} of {len(photos_caps_lines)} in photo caps file '{capsfile}': bad format.")
    return caps



def gen_file_html(photo_file_rel, caps, use_figcaption=False, force_path=None, thumbnail=None):
    """
    Generate HTML representation string for single photo file.

    Note: use_figcation is ignored if a thumbnail is given.
    """
    photo_filename = os.path.basename(photo_file_rel)
    cap = caps.get(photo_filename, "")

    if force_path is None:
        photo_path = photo_file_rel
    else:
        photo_path = os.path.join(force_path, photo_filename)

    if thumbnail is not None:
        if force_path is None:
            thumbnail_path = thumbnail
        else:
            thumbnail_filename = os.path.basename(thumbnail)
            thumbnail_path = os.path.join(force_path, thumbnail_filename)

    rep = ""
    if thumbnail is not None:
        rep += f'<a target="blank_" href="{photo_path}">'
        rep += f'<img src="{thumbnail_path}", alt="{cap}"/>"'
        rep += '</a>\n'
    else:
        rep += f'<img src="{photo_path}", alt="{cap}"/>"\n'
        if use_figcaption and len(cap) > 0:
            rep += f"<figcaption>{cap}</figcaption>\n"
    return rep


if __name__ == "__main__":
    gengal()
