#!/bin/bash

if [[ -v yn_override ]]; then
  yn=${yn_override}
else
  read -p "Do you want to proceed with ${SETUP_SECTION}? (y/n) " yn
fi

if [[ $yn == "y" || $yn == "Y" ]]; then
  source ${SETUP_SECTION_PATH}
elif [[ $yn == "n" || $yn == "N" ]]; then
  echo "${SETUP_SECTION}: Skipped..."
elif [[ $yn == "q" || $yn == "Q" ]]; then
  echo "Quitting script."
  exit 0
else
  echo "Invalid response, quitting script."
  exit 1
fi
