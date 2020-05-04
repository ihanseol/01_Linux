
 echo 'this.file.text.gz' | awk 'BEGIN {FS=".";}{ for(i=1;i<=NF;i++) print $i;}'
