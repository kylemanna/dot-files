type -q exa
set exa_available $status

function ls --wraps='exa -s modified' --description 'alias ls exa -s modified'
  if test $exa_available -eq 0
    exa -s modified $argv
  else
    eval (type -P ls) --color -t $argv
  end
end
