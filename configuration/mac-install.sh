#! /bin/bash
# Ansible is starting to seem like a time suck and overkill,
# see how quickly we can get this to a state we like

# handle
function failed() {
    echo "[!] failed installing $1" \
        && echo "bi: $1" >> failure.log
}

# idempotent brew install
function bi() {
    item=$1
    if [ -z "$item" ]; then
        echo "[!] bi needs an argument."
    else
        command -v "$item" > /dev/null 2>&1 \
            && echo "[*] $item is already installed." \
            || { echo "[*] installing $item..."; brew install "$item"; } || failed "$item"
    fi
}

# idempotent brew cask install
function bci() {
    item=$1
    if [ -z "$item" ]; then
        echo "[!] bci needs an argument."
    else
        command -v "$item" > /dev/null 2>&1 \
            && echo "[*] $item is already installed." \
            || { echo "[*] installing $item..."; brew cask install "$item"; } || failed "$item"
    fi
}

function setup () {
    # check brew and brew cask and other download tools exist
    # TODO: setup homebrew & all necessary taps
}

function main() {
    echo "!! Did you read this link yet? if not, press Ctrl-C."
    echo "https://sourabhbajaj.com/mac-setup/SystemPreferences/"
    read  -n 1 -p "->" mainmenuinput
    setup
    bi "blah"

# browsers
    bci "google-chrome"
    bci "firefox"


# dev stuff
    bci "docker"
    bci "iterm2"
    bi "git"
    bi "vim"
    bi "bash-completion"
    bi "httpie"
    bi "cowsay"
    bi "wget"
    bi "nmap"


    # Python
    bi "pyenv"
    # TODO: add pyenv init to shell (should be in dotfiles)
    # TODO: install global python versions, then install pipenv
    echo "[*] setting up Pyenv & Pipenv..."
    pyenv install 3.7.1
    pyenv global 3.7.1
    

    # Node
    # TODO: setup NVM

    # Go
    bi "golang"

    # 
# misc
    bci "alfred"
    bci "virtualbox"
    bci "vagrant"
    bci "vagrant-manager"
    bci "slack"
}


# TODO: Do we like this ansible playbook better? https://github.com/geerlingguy/mac-dev-playbook/blob/master/default.config.yml
# TODO: configure our dotfiles
main