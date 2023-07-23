SETUP_SECTION="Aliases"
echo "${SETUP_SECTION}: Setting up..."
# set up bash aliases if not macOS
SETUP_SUBSECTION="bash aliases"
if [[ $(uname) != "Darwin"* ]]; then
  if grep -q "/aliases/" ~/.bashrc; then
    echo "${SETUP_SECTION}: ${SETUP_SUBSECTION} already set up."
  else
    echo "${SETUP_SECTION}: ${SETUP_SUBSECTION} setting up..."
    printf '\nsource %s/aliases/*\n' "${BASEDIR}" >> ~/.bashrc
    echo "${SETUP_SECTION}: ${SETUP_SUBSECTION} done."
  fi
  else
    echo "${SETUP_SECTION}: ${SETUP_SUBSECTION} skipped, not in use on macOS."
fi
# set up zsh aliases
SETUP_SUBSECTION="zsh aliases"
if grep -q "/aliases/" ~/.zshrc; then
  echo "${SETUP_SECTION}: ${SETUP_SUBSECTION} already set up."
else
  echo "${SETUP_SECTION}: ${SETUP_SUBSECTION} setting up..."
  printf '\nsource %s/aliases/*\n' "${BASEDIR}" >> ~/.zshrc
  echo "${SETUP_SECTION}: ${SETUP_SUBSECTION} done."
fi
echo "${SETUP_SECTION}: setup done."
