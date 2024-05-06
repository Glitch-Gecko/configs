# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Rbenv
export PATH="$HOME/.rbenv/shims:$PATH"

# pwntools
export PATH="$PATH:$HOME/.pwndbg-src/.venv/bin"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="catppuccin_mocha"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git dirhistory zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch notify
unsetopt autocd beep
bindkey -v
zstyle :compinstall filename '/home/nicolas/.zshrc'
autoload -Uz compinit
compinit


alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias s='sudo'
alias webup='python -m http.server 8000'
alias vi='nvim'
alias sudo='sudo '
alias fetch='neofetch --kitty'
alias ls='exa'
alias la='exa -lA'
alias ll='exa -l'
alias lls='ls | lolcat'
alias lla='la | lolcat'
alias lll='ll | lolcat'
alias lfetch='fetch | lolcat'
alias ltree='tree | lolcat'
alias latree='tree | lolcat -ad 1'
alias myip="curl http://ipecho.net/plain; echo"
alias vbox="env QT_QPA_PLATFORM=xcb virtualbox"
alias sclear="clear; source ~/.zshrc"
alias bth="sudo systemctl start bluetooth; nohup blueman-applet >/dev/null 2>&1 &"
alias bat="bat --paging=never"
alias gen="genact -m bruteforce"
alias matrix="cmatrix -ba -u 2"
alias bonsai="cbonsai -liWC"
alias code="codium"
alias rdp="xfreerdp /dynamic-resolution /drive:share,/tmp +clipboard /cert:ignore"
alias vpn="wg-quick up ~/Documents/Nic-s-Laptop.conf"
alias novpn="wg-quick down ~/Documents/Nic-s-Laptop.conf"
alias proc="ps faxo user,uid,pid,ppid,tt,start,exe,command"
alias autoghidra="/home/nicolas/.ghidra.py"
alias sss='searchsploit $1'
alias ssx='searchsploit -x $1'
alias ssm='searchsploit -m $1'

open() {
    for file in $(printf '%s\n' "$@"); do (xdg-open "$file" &); done
}

scan() {
    if [ -z ${RHOST+x} ]
        then RHOST=$1; shift
    else echo "RHOST is set to '$RHOST'"; fi
    sudo rustscan --ulimit 5000 -a $RHOST -- -g 53 -T3 -Pn -sV --disable-arp-ping $@
}

target() {
    RHOST=$1
    HTTPRHOST=http://$RHOST/
    HTTPSRHOST=https://$RHOST/
}

revsh() {
    if [[ $1 ]]; then
        port=$1
    else
        port=4444
    fi
    stty raw -echo; (echo 'python3 -c "import pty;pty.spawn(\"/bin/bash\")" || python -c "import pty;pty.spawn(\"/bin/bash\")"' ;echo "stty$(stty -a | awk -F ';' '{print $2 $3}' | head -n 1)"; echo reset;cat) | nc -lvnp $port && reset
}

ffuf-vhost() {
    arg_count=3
    if [[ $2 && $2 != -* ]]; then
        wordlist=$2
    else
        wordlist='/usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt'
        arg_count=2
    fi
    ffuf -c -H "Host: FUZZ.$1" -u http://$1 -w $wordlist ${@: $arg_count};
}

ffuf-dir() {
    arg_count=3
    if [[ $2 && $2 != -* ]]; then
        wordlist=$2
    else
        wordlist='/usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt'
        arg_count=2
    fi
    ffuf -c -u $1FUZZ -w $wordlist ${@: $arg_count};
}

ffuf-php() {
    arg_count=3
    if [[ $2 && $2 != -* ]]; then
        wordlist=$2
    else
        wordlist='/usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt'
        arg_count=2
    fi
    ffuf -c -u $1FUZZ.php -w $wordlist ${@: $arg_count};
}

extract() {
  if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ]; then
      case $1 in
        *.tar.bz2)   tar xvjf $1    ;;
        *.tar.gz)    tar xvzf $1    ;;
        *.tar.xz)    tar xvJf $1    ;;
        *.lzma)      unlzma $1      ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar x -ad $1 ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xvf $1     ;;
        *.tbz2)      tar xvjf $1    ;;
        *.tgz)       tar xvzf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *.xz)        unxz $1        ;;
        *.exe)       cabextract $1  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}

mcd()
{
    test -d "$1" || mkdir "$1" && cd "$1"
}

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

fortune | cowsay -f stegosaurus | lolcat
eval "$(starship init zsh)"

eval $(thefuck --alias)
