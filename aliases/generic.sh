## shell config
alias zshvim='vim ~/.zshrc'
alias fishvim='vim ~/.config/fish/config.fish'
alias zshupd='source ~/.zshrc && echo "zsh environment has been updated."'
alias fishupd='source ~/.config/fish/config.fish && echo "fish environment has been updated."'

## folders
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd..='cd ..'

## common commands
alias diff='colordiff'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -v'
alias ping='ping -c 5'
alias dmesg='dmesg -HL'

## new commands
## du1
case $(uname) in
  Linux*)   alias du1='du --max-depth=1' ;;
  Darwin*)  alias du1='du -d 1' ;;
esac
alias hist='history | grep'
alias openports='ss --all --numeric -- processes --ipv4 --ipv6'

## default programs
# default programs can be added by writing suffix aliases
# `alias -s fileext=programname` as in
# `alias -s json=vim` or `alias -s {c,h,cpp,rb,rs}=vim`

## sudo commands
alias scat='sudo cat'
alias svim='sudo vim'

## upgr
case $(uname) in
  Linux*)
    case $(lsb_release -is) in
      EndeavourOS|Arch*) alias upgr='yay -Syu' ;;
      Ubuntu|Debian)     alias upgr='sudo apt update & sudo apt upgrade' ;;
      Fedora)            alias upgr='sudo dnf update && sudo dnf upgrade' ;;
    esac ;;
  Darwin*) alias upgr='brew update && brew upgrade' ;;
esac

## ssh
## sshk
case $(uname) in
  Linux*)   alias sshk='ssh-add ~/.ssh/id_ed25519' && alias sshkg='ssh-add ~/.ssh/google_compute_engine' && alias sshkr='ssh-add ~/.ssh/id_rsa' ;;
  Darwin*)  alias sshk='ssh-add ~/.ssh/id_ed25519 --apple-use-keychain' && alias sshkg='ssh-add ~/.ssh/google_compute_engine --apple-use-keychain' && alias sshkr='ssh-add ~/.ssh/id_rsa --apple-use-keychain' ;;
esac

## git
alias gitted='git ls-tree -r main --name-only' # list all git tracked files, ie all files "gitted"
alias gitupd='find ~/git -maxdepth 4 -type d -name ".git" -print -execdir git pull origin main \;'

## ls
alias ls='ls -Fh --color=auto'
alias ll='ls -lah'
alias lr='ls -R'
alias ls-ext='ll -BX'
alias ls-size='ll -rS'
alias ls-date='ll -rt'
alias llm='ll | less'

## safety measures
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -Iv --one-file-system'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
