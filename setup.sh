#!/bin/bash

## set var BASEDIR
BASEDIR=$(realpath "$(dirname "$0")")
printf 'The folder of the linux-config is:\n%s\n' "${BASEDIR}"

sudo () {
    [[ $EUID = 0 ]] || set -- command sudo "$@"
    "$@"
}

case $1 in
  -h | --help )
    echo "Haris\' Linux config setup script."
    echo "Usage: ./setup.sh [options]"
    echo "options:"
    echo "  -h, --help    display this help and exit"
    echo "  -y            yes to all options; execute whole script"
    echo "      --check   run this script in check mode; no to all options"
    exit 0 ;;
  -y ) yn_override=y; yes_to_prompts="-y";;
  --check ) yn_override=n;;
esac

SETUP_SECTION="Software installation"
SETUP_SECTION_PATH="${BASEDIR}/setup-scripts/software-installation.sh"
source ${BASEDIR}/setup-scripts/_yn_prompt.sh

SETUP_SECTION="Aliases"
SETUP_SECTION_PATH="${BASEDIR}/setup-scripts/shell-aliases.sh"
source ${BASEDIR}/setup-scripts/_yn_prompt.sh

SETUP_SECTION="vim config"
SETUP_SECTION_PATH="${BASEDIR}/setup-scripts/vim-config.sh"
source ${BASEDIR}/setup-scripts/_yn_prompt.sh

SETUP_SECTION="linux-config aliases"
SETUP_SECTION_PATH="${BASEDIR}/setup-scripts/linux-config-aliases.sh"
source ${BASEDIR}/setup-scripts/_yn_prompt.sh

echo "Setup completed."

echo "Reload the shell to apply the config."
