## open/apply config
alias bashvim='vim ~/.bashrc'
alias zshvim='vim ~/.zshrc'
alias bashupd='source ~/.bashrc && echo "bash environment has been updated."'
alias zshupd='source ~/.zshrc && echo "zsh environment has been updated."'
alias vimvim='vim ~/.vimrc'

## folders
alias ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ...='cd ../..'
alias ....='cd ../../..'

## common commands
alias diff='colordiff'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -ch'
alias mkdir='mkdir -v'
alias ping='ping -c 5'
alias dmesg='dmesg -HL'
alias free='free -h'

## new commands
## du1
case $(uname) in
  Linux*)   alias du1='du --max-depth=1'; alias dua='du -ha --max-depth=1' ;;
  Darwin*)  alias du1='du -d 1' ;;
esac
alias hist='history | grep'
alias openports='ss --all --numeric -- processes --ipv4 --ipv6'
## mkcd (mkdir + cd)
mkcd () {
    mkdir -- "$1" &&
    cd -- "$1" &&
    echo Changed directory to $1
}

## default programs
# default programs can be added by writing suffix aliases
# `alias -s fileext=programname` as in
# `alias -s json=vim` or `alias -s {c,h,cpp,rb,rs}=vim`

## sudo commands
alias sless='sudo less'
alias scat='sudo cat'
alias svim='sudo vim'
alias sus='sudo -i'
alias rsnow='sudo systemctl reboot'
alias sdnow='sudo systemctl poweroff'

## upgr
case $(uname) in
  Linux*)
    case $(lsb_release -is) in
      EndeavourOS|Arch*) alias upgr='yay -Syu' ;;
      Ubuntu|Debian)     alias upgr='sudo apt update && sudo apt upgrade' ;;
      Fedora)            alias upgr='sudo dnf update && sudo dnf upgrade' ;;
    esac ;;
  Darwin*) alias upgr='brew update && brew upgrade' ;;
esac

## ssh
alias sshvim='vim ~/.ssh/config'
## sshk
case $(uname) in
  Linux*)   alias sshk='ssh-add ~/.ssh/id_ed25519' && alias sshkg='ssh-add ~/.ssh/google_compute_engine' && alias sshkr='ssh-add ~/.ssh/id_rsa' ;;
  Darwin*)  alias sshk='ssh-add ~/.ssh/id_ed25519 --apple-use-keychain' && alias sshkg='ssh-add ~/.ssh/google_compute_engine --apple-use-keychain' && alias sshkr='ssh-add ~/.ssh/id_rsa --apple-use-keychain' ;;
esac

## git
alias gitted='git ls-tree -r main --name-only' # list all git tracked files, ie all files "gitted"
alias gitupd='find ~/git -maxdepth 4 -type d -name ".git" -print -execdir git pull origin main \;'

## ls
# alias ls='ls --color=auto'
alias ll='ls -Flah'
alias lr='ll -R'
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
alias cls='clear && echo -en "\e[3J"' # clear terminal in KDE Konsole for real
# alias cls='printf "\033c"' # clear terminal in console (does not work in KDE Konsole)
# rm alternative w/ timeout, not stored in history
# alias rm=' timeout 3 rm -Iv --one-file-system'
