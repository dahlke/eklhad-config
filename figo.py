#!/usr/local/bin/python3
from shutil import copy
import argparse
import json
import os

COLLLECTED_PREFIX_DST = "collected"
FILE_CONFIG_PATH = "config/files.json"

def collect(files):
    for f in files:
        if not os.path.exists(f['dst_dir']):
            os.mkdir(f['dst_dir'])

        # TODO: compare files and allow confirmation
        src_abs_path = f["src_abs_path"]
        if os.path.exists(src_abs_path):
            copy(f['src_abs_path'], f['dst_abs_path'])
            print(f['src_abs_path'], 'copied to', f['dst_abs_path'])
        else:
            print(src_abs_path, "does not exist, skipping.")

def apply(files):
    for f in files:
        if not os.path.exists(f["src_abs_path"]):
            os.makedirs(f["src_abs_path"], exist_ok=True)
        copy(f['dst_abs_path'], f['src_abs_path'])
        print(f['dst_abs_path'], 'copied to', f['src_abs_path'])

def main():
    files = []

    with open(FILE_CONFIG_PATH, 'r') as f:
        raw_data = json.load(f)
        files = raw_data['files']

        for f in files:
            src = os.path.abspath(os.path.expanduser(f['src']))
            dst = os.path.abspath(os.path.expanduser(f['dst'])) % COLLLECTED_PREFIX_DST
            dst_dir = os.path.dirname(dst)

            f['src_abs_path'] = src
            f['dst_abs_path'] = dst
            f['dst_dir'] = dst_dir

    if args.collect:
        collect(files)
    elif args.apply:
        apply(files)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog='figo')
    parser.add_argument('-c', '--collect', action='store_true', help='Collect the files from config/files.json and store in collected dir.')
    parser.add_argument('-a', '--apply', action='store_true', help='Apply the files from collected dir to the local machine.')
    args = parser.parse_args()

    if not (args.collect or args.apply):
        parser.error('No action requested, add --collect or --apply')

    main()