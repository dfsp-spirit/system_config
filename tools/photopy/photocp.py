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

    for pi in photo_infos:
        if inherit:
            if len(pi.strip()) >= template:
                template = pi
                pattern = pi
            else:
                pattern = template
                for char_idx, char in enumerate(pi):
                    if char != " ":
                        pattern[char_idx] = char
            if verbose:
                print(f" - Checking inherited pattern '{pattern}' from photo file entry '{pi}'.")
        else:
            pattern = pi.strip()
            if verbose:
                print(f" - Checking non-inherited pattern '{pattern}' from photo file entry '{pi}'.")
        hits = []
        for img in img_files:
            if pattern in img:
                hits.append(img)
        print(f"Photo pattern '{pi}' matches {len(hits)} files: {hits}")



if __name__ == "__main__":
    photocp()
