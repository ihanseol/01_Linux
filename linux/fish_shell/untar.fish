#!/usr/bin/fish
function untar --description "Expand/extract tar files"
    set --local ext (echo $argv[1] | awk -F. '{print $NF}')
    switch $ext
        case tar
            tar -xvf $argv[1]
        case gz
            tar -zxvf $arg[1]
        case bz2
            tar -jxvf $argv[1]
        case '*'
            echo "unknown extension"
    end
end



