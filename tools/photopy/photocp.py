#!/usr/bin/env python

import os
import argparse
import glob
import sys

def photocp():
    parser = argparse.ArgumentParser(description="Copy photos.")
    parser.add_argument("-i", "--indir", help="The input dir, must exist and be readble.", default=os.getcwd())
    parser.add_argument("-o", "--outdir", help="Thr output dir. Must exist and be writable", default=os.path.join(os.getcwd(), "out"))
    parser.add_argument("-p", "--photos", help="Readable text file containing one photo per line.", default="photos.txt")
    parser.add_argument("-a", "--inherit", help="Whether to inherit blank photo characters from ancestor.", action="store_true")
    parser.add_argument("-v", "--verbose", help="Increase output verbosity.", action="store_true")
    args = parser.parse_args()

    indir = args.indir
    outdir = args.outdir
    photos_file = args.photos
    verbose = args.verbose
    extension = "jpg"

    if not os.path.isdir(indir):
        raise ValueError(f"Directory indir '{indir}' cannot be read.")
    if not os.path.isdir(outdir):
        raise ValueError(f"Directory outdir '{outdir}' cannot be read.")
    if not os.path.isfile(photos_file):
        raise ValueError(f"File photosfile '{photos_file}' cannot be read.")
    img_files = glob.glob(f"{indir}/*.{extension}")

    print(f"Found {len(img_files)} photos with extension '{extension}' in input dir.")
    if verbose:
        for img in img_files:
            print(img)
    print(f"Found {len(img_files)} photos with extension '{extension}' in input dir.")

    photo_infos = [line.rstrip() for line in open(photos_file, 'r')]

    print(f"Found {len(photo_infos)} entries in the photos list from file '{photos_file}'.")

    if len(photo_infos) < 1:
        sys.exit(0)  # We're done.

    inherit = args.inherit
    if inherit:
        template = photo_infos[0]

    num_unique = 0
    num_ambiguous = 0
    for pi_line, pi in enumerate(photo_infos):
        if verbose:
                print(f" * Handling photo file entry '{pi}'.")
        if inherit:
            if(len(template) < len(pi)):
                raise ValueError(f"Current template '{template}' is shorter than new photo info entry '{pi}', which must not happen.")
            pattern = list(template)

            for char_idx, char in enumerate(pi):
                if char != " ":
                    pattern[char_idx] = char
            pattern = "".join(pattern)  # Turn char list back into str.
            template = pattern
            if verbose:
                print(f"   - Checking inherited pattern '{pattern}' from photo file entry '{pi}'.")
        else:
            pattern = pi.strip()
            if verbose:
                print(f"   - Checking non-inherited pattern '{pattern}' from photo file entry '{pi}'.")
        hits = []
        for img in img_files:
            if pattern in img:
                hits.append(img)

        if len(hits) == 1:
            num_unique += 1
            if verbose:
                print(f"    Photo pattern '{pi}' matches {len(hits)} files: {hits}")
        else:
            print(f"    WARNING: Photo pattern '{pi}' on line {pi_line} matches {len(hits)} files: {hits}")
            num_ambiguous += 1

    print(f"Checked {num_ambiguous + num_unique} photo entries: {num_ambiguous} ambiguous, {num_unique} unique.")





if __name__ == "__main__":
    photocp()
