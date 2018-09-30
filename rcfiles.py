#!/usr/bin/env python
import os
import sys
import subprocess
import argparse
import logging

BASE_DIR = os.path.dirname(os.path.realpath(__file__))

from logging import Formatter, StreamHandler

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
_handler = StreamHandler()
_handler.setFormatter(Formatter(
    '%(asctime)s %(levelname)s: %(message)s',
    '%Y-%m-%d %H:%M:%S'
))
logger.addHandler(_handler)

def error(msg, *args, **kwargs):
    logger.error(msg, *args)
    if 'exit' in kwargs and kwargs['exit']:
        sys.exit(1)

class Command():
    def update_submodules(self):
        proc = subprocess.Popen(['git', 'submodule', 'init'])
        ret = proc.wait()
        if ret != 0:
            error("Failed to initialize git submodules", exit=True)

        proc = subprocess.Popen(['git', 'submodule', 'update'])
        ret = proc.wait()
        if ret != 0:
            error("Failed to update git submodules", exit=True)

    def recompile_vim_plugins(self):
        import platform
        if platform.system() != 'Darwin':
            print "!! Can not auto-compile vim plugins.  Please compile them yourself."
            print " * YouCompleteMe"
            return

        logger.info('Attempting compilation of Vim plugins... This may take awhile.')

        os.chdir(os.path.join(BASE_DIR, 'dotfiles/vim/bundle/YouCompleteMe'))
        proc = subprocess.Popen(['/bin/sh', 'install.sh'],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        ret = proc.wait()
        if ret != 0:
            error("Failed to compile YouCompleteMe", exit=True)

class Install(Command):
    def __init__(self, options):
        self.options = options
        self.update_submodules()
        self.install_dotfiles()
        self.install_vundle()
        if not options.skip_compile:
            self.recompile_vim_plugins()

    def install_dotfiles(self):
        to_install = os.listdir(os.path.join(BASE_DIR, 'dotfiles'))
        to_install = self.filter_shellfiles(to_install)
        for source in to_install:
            source_path = os.path.join(BASE_DIR, 'dotfiles', source)
            target_path = os.path.join(os.environ['HOME'], '.' + source)
            self.remove_file(target_path)
            os.symlink(source_path, target_path)
            logger.info('Linked %s', source_path)

    def filter_shellfiles(self, dotfiles):
        if self.options.shell == 'zsh':
            return [f for f in dotfiles if 'bash' not in f]
        elif self.options.shell == 'bash':
            return [f for f in dotfiles if 'zsh' not in f]

    def remove_file(self, target):
        proc = subprocess.Popen(['rm', '-rf', target],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        ret = proc.wait()
        if ret != 0:
            error("Failed to remove file %s", target, exit=True)

    def install_vundle(self):
        proc = subprocess.Popen(['vim', '-c', 'BundleInstall', '-c', 'quitall'])
        ret = proc.wait()
        if ret != 0:
            error("Failed to install vim plugins...", exit=True)

class Update(Command):
    def __init__(self, options):
        self.options = options
        self.update_git()
        self.update_submodules()
        self.update_vundle()
        if not options.skip_compile:
            self.recompile_vim_plugins()

    def update_git(self):
        proc = subprocess.Popen(['git', 'pull'])
        ret = proc.wait()
        if ret != 0:
            error("Failed to pull latest changes", exit=True)

    def update_vundle(self):
        proc = subprocess.Popen(['vim', '-c', 'BundleUpdate', '-c', 'quitall'])
        ret = proc.wait()
        if ret != 0:
            error("Failed to update vundle, I recommend running :BundleInstall inside vim.", exit=True)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers()

    subparser = subparsers.add_parser('install', help="Install rcfiles into your home directory.")
    subparser.add_argument('--shell', default="zsh", choices=["zsh", "bash"], help="Which shell you want to install rc files for.")
    subparser.add_argument('--skip-compile', action="store_true", help="Skip compilation of Vim plugins")
    subparser.set_defaults(CommandClass=Install)

    subparser = subparsers.add_parser('update', help="Update rcfiles.")
    subparser.add_argument('--skip-compile', action="store_true", help="Skip compilation of Vim plugins")
    subparser.set_defaults(CommandClass=Update)

    options = parser.parse_args()
    command = options.CommandClass(options)
