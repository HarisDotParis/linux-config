#!/bin/bash

## set var BASEDIR
BASEDIR=$(realpath "$(dirname $0)")
printf "The folder of the linux-config is:\n${BASEDIR}\n"

## setup aliases
echo "Aliases: Setting up..."
# set up bash aliases if not macOS
if [[ $(uname) != "Darwin"* ]]; then
  if grep -q "_aliasindex_bash" ~/.bashrc; then
    printf "Aliases: bash aliases already set up.\n"
  else
    printf "Aliases: bash aliases setting up...\n"
    printf "\nsource ${BASEDIR}/_aliasindex_bash\n" >> ~/.bashrc
    printf "Aliases: bash aliases done.\n"
  fi
  else
    echo "Aliases: bash aliases skipped, not in use on macOS."
fi
# set up zsh aliases
if grep -q "_aliasindex_bash" ~/.zshrc; then
  printf "Aliases: zsh aliases already set up.\n"
else
  printf "Aliases: zsh aliases setting up...\n"
  printf "\nsource ${BASEDIR}/_aliasindex_bash\n" >> ~/.zshrc
  printf "Aliases: zsh aliases done.\n"
fi
# set up fish aliases
if grep -q "_aliasindex_fish" ~/.config/fish/config.fish; then
  printf "Aliases: fish aliases already set up.\n"
else
  printf "Aliases: fish aliases setting up...\n"
  printf "\nsource ${BASEDIR}/_aliasindex_fish\n" >> ~/.config/fish/config.fish
  printf "Aliases: fish aliases done.\n"
fi
echo 'Aliases: setup done.'

echo "Setup completed."