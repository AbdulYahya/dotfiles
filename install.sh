#!/bin/zsh

export PATH="/opt/homebrew/bin:/usr/local/bin:${PATH}"
caffeinate & # Prevent Mac from going to sleep

tmp_dir="${mktemp -d}"
curl --location 'https://github.com/abdulyahya/dotfiles/archive/master.zip' | ditto -xk - "${tmp_dir}"

for shell_script in "${tmp_dir}/dotfiles-master/scripts/"*.sh; do
    source "${shell_script}"
done

function show_options {
    clear

    echo "
        What do you want to do?

        [1] Update System.
        [2] Configure MacOS.
        [3] Setup Language Environments.
        [4] Install Apps.
        [5] Configure Tools.
        [0] Quit.
    " | sed -E 's/ {4}//'

    read -n1 -rp 'Pick an option: ' option
    clear

    if [[ "${option}" -eq 1 ]]; then
        sync_icloud
        appstore_login
        update_system
    elif [[ "${option}" -eq 2 ]]; then
        echo 'Try again.' >&2
    elif [[ "${option}" -eq 3 ]]; then
        install_node
    elif [[ "${option}" -eq 4 ]]; then
        echo 'Try again.' >&2
    elif [[ "${option}" -eq 5 ]]; then
        configure_git
    elif [[ "${option}" -eq 0 ]]; then
        # Let Mac go to sleep again
        killall 'caffinate'

        sudo --remove-timestamp

        return 0
    else
        echo 'Not a valid option. Try again.' >&2
    fi

    show_options
}

renew_sudo
show_options
