#!/bin/sh

test $# != 2 && { echo two arguments required; exit 1 ;}
for file
do
    test "$file" = - && continue   # 인수로 '-' 가 사용될 경우
    test -e "$file" || { echo "$file" does not exist; exit 1 ;}
    test -d "$file" && { echo "$file" is a directory; exit 1 ;}
    test -r "$file" || { echo "$file" is not readable; exit 1 ;}
done
