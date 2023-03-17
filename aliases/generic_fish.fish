## du1
switch (uname)
  case "Linux*";  alias du1='du --max-depth=1'
  case "Darwin*"; alias du1='du -d 1'
end

###### upgr command missing
switch (uname)
  case "Linux*"
    switch (lsb_release -is)
      case "EndeavourOS" "Arch*"; alias upgr='yay -Syu'
      case "Ubuntu" "Debian"    ; alias upgr='sudo apt update && sudo apt upgrade'
      case "Fedora"             ; alias upgr='sudo dnf update && sudo dnf upgrade'
    end
  case "Darwin*"; alias upgr='brew update && brew upgrade'
end

## sshk
switch (uname)
  case "Linux*";  alias sshk='ssh-add ~/.ssh/id_ed25519'
  case "Darwin*"; alias sshk='ssh-add --apple-use-keychain ~/.ssh/id_ed25519'
end

## sshkg
switch (uname)
  case "Linux*";  alias sshkg='ssh-add ~/.ssh/google_compute_engine'
  case "Darwin*"; alias sshkg='ssh-add ~/.ssh/google_compute_engine --apple-use-keychain'
end