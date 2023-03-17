#!/bin/bash

## set var BASEDIR
BASEDIR=$(realpath "$(dirname "$0")")
printf 'The folder of the linux-config is:\n%s\n' "$BASEDIR"

###################################
###### software installation ######
###################################

SETUP_SECTION="Software"

read -p "Do you want to proceed with installing necessary software? (yes/no)" yn
case $yn in
  yes ) echo OK, proceeding...; echo Software: Setting up...;;
  no  ) echo Exiting...;
        exit;;
  *   ) echo Invalid response, quitting script.;
        exit 1;;
esac

SAME_NAMED_PACKAGES_TO_BE_INSTALLED=(bash bash-completion zsh zsh-autosuggestions zsh-syntax-highlighting fish xsel)

case $(uname) in
  Linux )
    echo "${SETUP_SECTION}: Linux detected, installing software..."
    case $(lsb_release -is) in
      Ubuntu | Debian )
        echo "${SETUP_SECTION}: system using apt detected, starting installation..."
        sudo apt update && sudo apt install ${SAME_NAMED_PACKAGES_TO_BE_INSTALLED[*]} zsh-doc doc-base
        echo "${SETUP_SECTION}: installation done via apt";;
      Fedora )
        echo "${SETUP_SECTION}: system using dnf detected, starting installation..."
        sudo dnf update && sudo dnf install ${SAME_NAMED_PACKAGES_TO_BE_INSTALLED[*]}
        echo "${SETUP_SECTION}: installation done via dnf";;
      Arch | EndeavourOS )
        echo "${SETUP_SECTION}: system using pacman detected, starting installation..."
        sudo pacman -Syyu && sudo pacman -S ${SAME_NAMED_PACKAGES_TO_BE_INSTALLED[*]}
        echo "${SETUP_SECTION}: installation done via pacman";;
      * ) echo "${SETUP_SECTION}: Unknown Linux distro, exiting..."; exit 1;;
    esac;;
  Darwin )
    echo "${SETUP_SECTION}: macOS detected, installing software..."
    case $(which brew) in
      /opt/homebrew/bin/brew )
        echo "${SETUP_SECTION}: Homebrew already installed, installing software..."
        brew ${SAME_NAMED_PACKAGES_TO_BE_INSTALLED[*]} vim
        echo "${SETUP_SECTION}: installation done via Homebrew";;
      * )
        echo "${SETUP_SECTION}: Homebrew not installed, installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "${SETUP_SECTION}: Homebrew installed successfully, please restart Terminal and re-run this script."
        exit 1;;
    esac;;
  * ) echo "${SETUP_SECTION}: Unknown OS, exiting..."; exit 1;;
esac

echo "${SETUP_SECTION}: setup done."

read -p "Do you want to proceed with setting up shell aliases? (yes/no)" yn
case $yn in
  yes ) echo OK, proceeding...;;
  no  ) echo Exiting...;
        exit;;
  *   ) echo Invalid response, quitting script.;
        exit 1;;
esac

###########################
###### shell aliases ######
###########################

SETUP_SECTION="Aliases"

echo "${SETUP_SECTION}: Setting up..."
# set up bash aliases if not macOS
if [[ $(uname) != "Darwin"* ]]; then
  if grep -q "_aliasindex_bash.sh" ~/.bashrc; then
    echo "${SETUP_SECTION}: bash aliases already set up."
  else
    echo "${SETUP_SECTION}: bash aliases setting up..."
    printf '\nsource %s/aliases/_aliasindex_bash.sh\n' "${BASEDIR}" >> ~/.bashrc
    echo "${SETUP_SECTION}: bash aliases done."
  fi
  else
    echo "${SETUP_SECTION}: bash aliases skipped, not in use on macOS."
fi
# set up zsh aliases
if grep -q "_aliasindex_bash.sh" ~/.zshrc; then
  echo "${SETUP_SECTION}: zsh aliases already set up."
else
  echo "${SETUP_SECTION}: zsh aliases setting up..."
  printf '\nsource %s/aliases/_aliasindex_bash.sh\n' "${BASEDIR}" >> ~/.zshrc
  echo "${SETUP_SECTION}: zsh aliases done."
fi
# set up fish aliases
if grep -q "_aliasindex_fish.fish" ~/.config/fish/config.fish; then
  echo "${SETUP_SECTION}: fish aliases already set up."
else
  echo "${SETUP_SECTION}: fish aliases setting up..."
  printf '\nsource %s/aliases/_aliasindex_fish.fish\n' "${BASEDIR}" >> ~/.config/fish/config.fish
  echo "${SETUP_SECTION}: fish aliases done."
fi
echo "${SETUP_SECTION}: setup done."

echo "Setup completed."
