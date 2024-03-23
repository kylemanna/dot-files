type -q lsd
set lsd_available $status

type -q eza
set eza_available $status

function ls --wraps='lsd' --description 'LS Deluxe'
  if test "$lsd_available" -eq 0
    lsd -tr $argv
  else if test "$eza_available" -eq 0
    eza -t modified $argv
  else
    eval (type -P ls) --color -t $argv
  end
end
