## set var BASEDIR
BASEDIR=$(realpath "$(dirname "$0")")
printf 'The folder of the linux-config is:\n%s\n' "${BASEDIR}"

sudo () {
    [[ $EUID = 0 ]] || set -- command sudo "$@"
    "$@"
}

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
