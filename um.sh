
umedit () {
    mkdir -p "$HOME/man/"
    emacsclient -c "$HOME/man/$1.org"
}

umview () {
    if [[ -e "$HOME/man/$1.org" ]]; then
        pandoc -s -f org -t man "$HOME/man/$1.org" |
            tbl |
            groff -Wall -mtty-char -man -Tascii -c |
            less -R
    else
        umedit "$1"
    fi
}

umrm () {
    if [[ -n "$1" ]]; then
        rm -i "$HOME/man/$1.org"
    fi
}

um () {
    case "$1" in
        -e) umedit "$2" ;;
        edit) umedit "$2" ;;
        -r) umrm "$2" ;;
        rm) umrm "$2" ;;
        *) umview "$1" ;;
    esac
}

