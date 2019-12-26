. ~/.config/fish/aliases.fish

# Fish prompt/color config {{{

set MAXCOUNT 1
set RANGE 2
set count 1

while [ $count -le $MAXCOUNT ]
    set number (random)
    set number (math  $number % $RANGE)
    set count (math $count + 1 )
end

if [ $number -eq 0 ]
    fortune | cowsay
else
    fortune | ponysay
end

# Globals
set -gx EDITOR vim


