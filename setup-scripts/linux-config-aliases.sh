SETUP_SECTION="vim config"
echo "${SETUP_SECTION}: Setting up..."
if [[ -f ${BASEDIR}/aliases/local_linux_config_aliases ]]; then
  echo "${SETUP_SECTION}: already set up."
else
  echo "${SETUP_SECTION}: setting up..."
  printf 'alias cdlc="cd %s"\n' "${BASEDIR}" >> ${BASEDIR}/aliases/local_linux_config_aliases
  printf 'alias vimal="vim %s/aliases/generic.sh"\n' "${BASEDIR}" >> ${BASEDIR}/aliases/local_linux_config_aliases
  printf 'alias vimconf="vim %s/software-config/vim/.vimrc"\n' "${BASEDIR}" >> ${BASEDIR}/aliases/local_linux_config_aliases
  echo "${SETUP_SECTION}: setup done."
fi
