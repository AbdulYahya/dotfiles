function configure_git {
    ask 'Request a Github token to `cli-approve-token`.'
    cli-approve-button --ensure-token
    ask 'Request a Github token for `cli-merge-button`.'
    cli-merge-button --ensure-token
}
