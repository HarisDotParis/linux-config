SETUP_SECTION="vim config"
if grep -q "/software-config/vim/.vimrc" ~/.vimrc; then
  echo "${SETUP_SECTION}: already set up."
else
  echo "${SETUP_SECTION}: setting up..."
  printf '\nso %s/software-config/vim/.vimrc\n' "${BASEDIR}" >> ~/.vimrc
  echo "${SETUP_SECTION}: setup done."
fi
