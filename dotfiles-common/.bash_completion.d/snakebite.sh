_snakebite()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    if [[ ${cur} == "hls" ]]; then
        cur="snakebite"
        prev="ls"
    fi
    if [[ ${cur} == "hdu" ]]; then
        cur="snakebite"
        prev="du"
    fi
    if [[ ${cur} == "htxt" ]]; then
        cur="snakebite"
        prev="text"
    fi

    if [[ ${prev} != "snakebite" ]]; then
        local IFS=$'\t\n'
        if [[ $cur != /* ]] ; then
            cur="/user/$(whoami)/$cur"
        fi
        last_root=$(echo $cur | grep -o "^/\([^/]*/\)*")
        opts=$(snakebite complete $last_root)

        if [[ ${cur} == * ]]; then
            COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
            [[ $COMPREPLY = */ ]] && compopt -o nospace
            return 0
        fi
    else
        opts=$(snakebite commands)
        COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        return 0
    fi

}
complete -F _snakebite snakebite
complete -F _snakebite hls
complete -F _snakebite hdu
complete -F _snakebite htxt