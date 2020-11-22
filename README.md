# Eklhad Config

This repo is a way to keep me sane as I reason about my personal development configurations across different types of machines I use frequently. It contains a script to gather up common config like my `vimrc`, `zshrc`, global `gitignore`, etc. (full list in `config/files.json`), as well as some more static configuration reminders.

A tool to gather your configurations and store them here so you can migrate personal machines more easily. Mine are in the `collected/` dir here as an example and also for my own easy access.

## Cross *nix Platforms

### Collecting Config Files

To automate the collection of files, use the `figo.py` script, which will collect all files listed in `config/files.json`:

```bash
./figo.py --collect
```

### Applying Config Files

To apply all the files on a target host, use the apply command, making sure you have updated `config/files.json` for whatever the desired target paths are..

```bash
./figo.py --apply
```

## MacOS

[MACOS.md](./MACOS.md)

## Raspberry Pi (Ubuntu Linux)

[PI.md](./PI.md)
