# https://github.com/fish-shell/fish-shell/wiki/Bash-Style-Command-Substitution-and-Chaining-(!!-!$)#abbr-based-solution-for--since-220
function sudobangbang --on-event fish_postexec
    abbr -g !! $argv[1]
end
