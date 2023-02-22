# Haris' Linux Configs

This repository contains my Linux configuration files. I use it to keep my configs in sync across multiple machines. As these files are also meant to work for non-Linux Unix derivatives like macOS, and for all three major shells, I try to keep them as portable as possible.

This repository contains the following configs in separate folders:
- `aliases` - shell aliases for bash, zsh and fish
  - As bash/zsh and fish have different syntaxes, I have some separate files for each shell. The files `_aliasindex_bash` and `_aliasindex_fish` contain for loops to include all relevant alias files in that folder for each shell, and are sourced by the respective shell's config file.