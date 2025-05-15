#!/bin/env sh

_pkg_api() {
    (
        unfunction _pkg_api 2> /dev/null || unset _pkg_api
        dir="$1"
        opwd=$(pwd -L)
        cd "$dir" || return 1
        pnpm pkglinux
        cd "$opwd" || return 1
        return 0
    )
}

_pkg_electron() {
    (
        unfunction _pkg_electron 2> /dev/null || unset _pkg_electron
        dir="$1"
        opwd=$(pwd -L)
        cd "$dir" || return 1
        pnpm build && pnpm electron:build --linux --x64
        cd "$opwd" || return 1
        return 0
    )
}

_main() {
    (
        unfunction _main 2> /dev/null || unset _main
        here=$(dirname "$0")
        opwd=$(pwd -L)
        cd "$here" || return 1
        here=$(pwd -L)
        cd "$opwd" || return 1
        api_dir="$here/api"
        src_dir="$here"
        _pkg_api "$api_dir" && _pkg_electron "$src_dir"
        return $?
    )
}

_main "$@"
