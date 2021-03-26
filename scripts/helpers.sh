function message {
    local -r bullet_color="${1}"
    local -r message="${2}"
    local -r all_colors=('black' 'red' 'green' 'yellow' 'blue' 'magenta' 'cyan' 'white')

    for i in "${!all_colors[@]}"; do
        if [[ "${all_colors[${i}]}" == "${bullet_color}" ]]; then
            local color_index="${i}"
            echo -e "$(tput setaf "${i}")•$(tput sgr0) ${message}"
            break
        fi
    done

    if [[ -z "${color_index}" ]]; then
        echo "${FUNCNAME[0]}: '${bullet_color}' is not a valid color."
        return 1
    fi
}

# Ask for input from user in the Terminal
function ask {
    (afplay /System/Library/Sounds/Hero.aiff &) # Run in a subshell so that the job runs in the background.
    message 'magenta' "${1}"
}

# Ask for a manual GUI action
function ask_gui {
    local -r message="${1}"
    local -r apps="${2}"
    shift 2

    ask "${message}"
    open -Wa "${app}" --args "${0}" # Do not continue until the app closes
}

# Open `System Preferences` in a specified pane
function ask_system_preferences {
    # ...
}

function ask_chromium {
    # ...
}

# General info
function info {
    message 'green' "${1}"
}

function renew_sudo {
    if ! sudo --non-interactive true 2> /dev/null; then
        ask 'Extend `sudo` timeout by giving your password now (will not be echoed).'
    fi

    sudo --validate
}

