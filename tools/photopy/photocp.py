#!/usr/bin/env python

import os
import argparse
import glob

def photocp():
    parser = argparse.ArgumentParser(description="Copy photos.")
    parser.add_argument("-i", "--indir", help="The input dir, must exist and be readble.", default=os.getcwd())
    parser.add_argument("-o", "--outdir", help="Thr output dir. Must exist and be writable", default=os.path.join(os.getcwd(), "out"))
    parser.add_argument("-v", "--verbose", help="Increase output verbosity.", action="store_true")
    args = parser.parse_args()

    indir = args.indir
    outdir = args.outdir

    if not os.path.isdir(indir):
        raise ValueError(f"Directory indir {indir} cannot be read.")
    if not os.path.isdir(outdir):
        raise ValueError(f"Directory outdir {outdir} cannot be read.")
    img_files = glob.glob(f"{indir}/*.jpg")

    print(f"Found {len(img_files)} photos.")
    for img in img_files:
        print(img)

if __name__ == "__main__":
    photocp()
