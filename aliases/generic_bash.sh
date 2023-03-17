## du1
case $(uname) in
  Linux*)   alias du1='du --max-depth=1' ;;
  Darwin*)  alias du1='du -d 1' ;;
esac

## upgr
case $(uname) in
  Linux*)
    case $(lsb_release -is) in
      EndeavourOS|Arch*) alias upgr='yay -Syu' ;;
      Ubuntu|Debian)     alias upgr='sudo apt update & sudo dnf upgrade' ;;
      Fedora)            alias upgr='sudo dnf update && sudo dnf upgrade' ;;
    esac ;;
  Darwin*) alias upgr='brew update && brew upgrade' ;;
esac

## sshk
case $(uname) in
  Linux*)   alias sshk='ssh-add ~/.ssh/id_ed25519' ;;
  Darwin*)  alias sshk='ssh-add ~/.ssh/id_ed25519 --apple-use-keychain' ;;
esac

## sshkg
case $(uname) in
  Linux*)   alias sshkg='ssh-add ~/.ssh/google_compute_engine' ;;
  Darwin*)  alias sshkg='ssh-add ~/.ssh/google_compute_engine --apple-use-keychain' ;;
esac