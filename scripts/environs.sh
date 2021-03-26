# Brew

# Python

function install_node {
    info 'Installing Node and packages.'

    rm -rf "${HOME}/.nvm" # Delete previous install
    brew install nvm

    # Activate nvm
    mkdir "${HOME}/.nvm"
    export NVM_DIR="${HOME}/.nvm"
    [ -s "${HOMEBREW_PREFIX}/opt/nvm.nvm.sh" ] && source "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh"

    nvm install node # Install latest node

    # Install packages
    npm install --global neovim
}
