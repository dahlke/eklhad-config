#!/usr/bin/python
from shutil import copy
import os

PREFIX_MACOS = "/Users"
PREFIX_LINUX = "/home"
PREFIX_DEST = "config"

KNOWN_USERNAMES = ["neil", "dahlke", "eklhad"]
OPERATING_SYSTEMS = ["macos", "linux"]

FILES = [
    {
        "src": "~/.gitignore",
        "dst": "./config/gitignore"
    },
    {
        "src": "~/.ssh/config",
        "dst": "./config/ssh/config"
    },
    {
        "src": "~/.zshrc",
        "dst": "./config/zshrc"
    },
    {
        "src": "~/.vimrc",
        "dst": "./config/vimrc"
    }
]

if __name__ == "__main__":
    for file in FILES:
        src = os.path.abspath(os.path.expanduser(file['src']))
        dst = os.path.abspath(os.path.expanduser(file['dst']))
        dst_dir = os.path.dirname(dst)

        if not os.path.exists(dst_dir):
            os.mkdir(dst_dir)

        copy(src, dst)