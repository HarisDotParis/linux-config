SETUP_SECTION="linux-config aliases"
#if [[ -f ${BASEDIR}/aliases/local_linux_config_aliases.sh ]]; then
#  echo "${SETUP_SECTION}: already set up."
#else
  echo "${SETUP_SECTION}: setting up..."
  rm ${BASEDIR}/aliases/local_linux_config_aliases.sh
  printf 'alias cdlc="cd %s"\n' "${BASEDIR}" >> ${BASEDIR}/aliases/local_linux_config_aliases.sh
  printf 'alias alsvim="vim %s/aliases/generic.sh"\n' "${BASEDIR}" >> ${BASEDIR}/aliases/local_linux_config_aliases.sh
  printf 'alias vimconf="vim %s/software-config/vim/.vimrc"\n' "${BASEDIR}" >> ${BASEDIR}/aliases/local_linux_config_aliases.sh
  printf 'alias lcupd="git -C %s pull"\n' "${BASEDIR}" >> ${BASEDIR}/aliases/local_linux_config_aliases.sh
  echo "${SETUP_SECTION}: setup done."
#fi
