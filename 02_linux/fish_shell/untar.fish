function untar --description "Expand/extract tar files"
    set --local ext (echo $argv[1] | awk -F . '{print $NF}')
    echo $ext, $argv[1]
    switch $ext
        case tar
            echo 'this is tar'
            tar xvf $argv[1]
        case gz
            echo 'this is gz'
            tar -xvzf $argv[1]
        case bz2
            echo 'this is bz2'
            tar xvjf $argv[1]
        case '*'
            echo "unknown extension"
    end
end




