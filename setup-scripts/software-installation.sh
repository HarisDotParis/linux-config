SETUP_SECTION="software installation"
echo ${SETUP_SECTION}: setting up...
SAME_NAMED_PACKAGES_TO_BE_INSTALLED=(bash bash-completion zsh zsh-autosuggestions zsh-syntax-highlighting vim curl)
case $(uname) in
  Linux )
    echo "${SETUP_SECTION}: Linux detected, installing software..."
    case $(lsb_release -is) in
      Ubuntu | Debian )
        echo "${SETUP_SECTION}: system using apt detected, starting installation..."
        sudo apt update && sudo apt install ${SAME_NAMED_PACKAGES_TO_BE_INSTALLED[*]} zsh-doc
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
        brew install ${SAME_NAMED_PACKAGES_TO_BE_INSTALLED[*]} vim
        echo "${SETUP_SECTION}: installation done via Homebrew";;
      * )
        echo "${SETUP_SECTION}: Homebrew not installed, installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "${SETUP_SECTION}: Homebrew installed successfully, please restart Terminal and re-run this script."
        exit 1;;
    esac;;
  * ) echo "${SETUP_SECTION}: Unknown OS, exiting..."; exit 1;;
esac

SETUP_SUBSECTION="oh-my-zsh"
if [[ -d ~/.oh-my-zsh/ ]]; then
  echo "${SETUP_SECTION}: ${SETUP_SUBSECTION} already installed."
else
  echo "${SETUP_SECTION}: ${SETUP_SUBSECTION} installing..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "${SETUP_SECTION}: ${SETUP_SUBSECTION} installed successfully."
fi

echo "${SETUP_SECTION}: setup done."
