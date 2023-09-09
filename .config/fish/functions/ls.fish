type -q lsd
set lsd_available $status

function ls --wraps='lsd' --description 'LS Deluxe'
  if test $lsd_available -eq 0
    lsd -t $argv
  else
    eval (type -P ls) --color -t $argv
  end
end
