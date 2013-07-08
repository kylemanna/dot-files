#
# Helper functions that maintain the env cache
#

if [ -z "$ENV_CACHE"]; then
    export ENV_CACHE="$HOME/.cache/env"
fi

env-init() {
    mkdir -p "$(basename "$ENV_CACHE")"

    if [ "$1" = "reset" ]; then
        rm  -f "$ENV_CACHE"
    fi

    touch "$ENV_CACHE"
}

env-import() {
    while read line; do
        #echo "export ${line%%=*}=\"${line#*=}\""
        eval "export ${line%%=*}=\"${line#*=}\""
    done < "$ENV_CACHE"
}

env-dump() {
    cat "$ENV_CACHE"
}

env-set() {
    if [ $# -lt 1 ]; then
        echo "usage: $FUNCNAME KEY [VALUE]"
        return 1
    fi

    if [ $# -eq 1 ]; then
        #echo "Unsetting $1"
        sed -i "/^$1=/d" "$ENV_CACHE"
    else
        #echo "Setting $1=$2"
        tmp="$(mktemp "$ENV_CACHE.XXXXXXX")"
        awk "/^$1=/ { sub(\"^.*$\",\"$1=$2\"); found=1; }; { print } END{ if (found != 1) {print \"$1=$2\"} }" "$ENV_CACHE" > "$tmp"
        mv $tmp $ENV_CACHE
    fi
}

env-get() {
    if [ $# -lt 1 ]; then
        echo "usage: $FUNCNAME KEY"
        return 1
    fi
    awk "/^$1=/ {sub(\"^.?=\",\"\"); print; exit }" "$ENV_CACHE"
}


# src: http://raim.codingfarm.de/blog/2013/01/30/tmux-update-environment/
tmux() {
    local tmux=$(type -fp tmux)
    case "$1" in
        up)
            local v
            while read v; do
                if [[ $v == -* ]]; then
                    echo "Unset: $v"
                    unset ${v/#-/}
                else
                    # Add quotes around the argument
                    v=${v/=/=\"}
                    v=${v/%/\"}
                    eval export $v
                    echo "Export: $v"
                fi
            done < <(tmux show-environment)
            ;;
        *)
            $tmux "$@"
            ;;
    esac
}
