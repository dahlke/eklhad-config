#!/usr/bin/python
from shutil import copy
import os

PREFIX_DEST = "collected"

FILES = [
    {
        "src": "~/.gitignore",
        "dst": "./%s/gitignore"
    },
    {
        "src": "~/.ssh/config",
        "dst": "./%s/ssh/config"
    },
    {
        "src": "~/.zshrc",
        "dst": "./%s/zshrc"
    },
    {
        "src": "~/.vimrc",
        "dst": "./%s/vimrc"
    }
]

if __name__ == "__main__":
    for file in FILES:
        src = os.path.abspath(os.path.expanduser(file['src']))
        dst = os.path.abspath(os.path.expanduser(file['dst'])) % PREFIX_DEST
        dst_dir = os.path.dirname(dst)

        if not os.path.exists(dst_dir):
            os.mkdir(dst_dir)

        copy(src, dst)