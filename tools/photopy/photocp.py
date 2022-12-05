#!/usr/bin/env python

import os
import argparse
import glob

def photocp(indir, outdir):
    if not os.path.isdir(indir):
        raise ValueError(f"Directory indir {indir} cannot be read.")
    if not os.path.isdir(outdir):
        raise ValueError(f"Directory outdir {outdir} cannot be read.")
    img_files = glob.glob(f"{indir}/*.jpg")

    print(f"Found {len(img_files)} photos.")
    for img in img_files:
        print(img)

if __name__ == "__main__":
    indir = os.getcwd()
    outdir = os.path.join(indir, "out")
    photocp(indir, outdir)
