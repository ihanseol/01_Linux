#!/bin/bash

# $RANDOM 은 불릴 때마다 다른 무작위 정수 값을 리턴합니다.
# 명칭상의 범위(nominal range): 0 - 32767(16 비트 양의 정수).

MAXCOUNT=10
count=1

echo
echo "$MAXCOUNT 개의 랜덤한 숫자:"
echo "-----------------"
while [ "$count" -le $MAXCOUNT ]      # 10 ($MAXCOUNT) 개의 랜덤 정수 발생.
do
  number=$RANDOM
  echo $number
  let "count += 1"  # 카운터 증가.
done
echo "-----------------"

# 어떤 범위의 랜덤 값이 필요하다면 '나머지(modulo)' 연산자를 쓰면,
# 어떤 수를 나눈 나머지 값을 리턴해 줍니다.

RANGE=500

echo

number=$RANDOM
let "number %= $RANGE"
echo "$RANGE 보다 작은 랜덤한 숫자  ---  $number"

echo

# 어떤 값보다 큰 랜덤한 정수가 필요하다면 
# 그 값보다 작은 수는 무시하는 테스트 문을 걸면 됩니다.

FLOOR=200

number=0   # 초기화
while [ "$number" -le $FLOOR ]
do
  number=$RANDOM
done
echo "$FLOOR 보다 큰 랜덤한 숫자  ---  $number"
echo


# 상한값과 하한값 사이의 수가 필요하다면 위의 두 테크닉을 같이 쓰면 됩니다.
number=0   # 초기화
while [ "$number" -le $FLOOR ]
do
  number=$RANDOM
  let "number %= $RANGE"  # $number 가 $RANGE 안에 들어오게.
done
echo "$FLOOR 와 $RANGE 사이의 랜덤한 숫자  ---  $number"
echo


# "참"이나 "거짓"중에 하나를 고르도록 할 수도 있습니다.
BINARY=2
number=$RANDOM
T=1

let "number %= $BINARY"
# let "number >>= 14"    더 좋은 분포의 랜덤값을 줍니다.
# (마지막 두 비트를 제외하고 모두 오른쪽으로 쉬프트 시킴).
if [ "$number" -eq $T ]
then
  echo "TRUE"
else
  echo "FALSE"
fi  

echo


# 주사위 던지기를 흉내내 볼까요?
SPOTS=7   # 7 의 나머지(modulo)는 0 - 6.
DICE=2
ZERO=0
die1=0
die2=0

# 정확한 확률을 위해서 두 개의 주사위를 따로 던집시다.

  while [ "$die1" -eq $ZERO ]     # 주사위에 0은 없죠.
  do
    let "die1 = $RANDOM % $SPOTS" # 첫번째 주사위를 굴리고.
  done  

  while [ "$die2" -eq $ZERO ]
  do
    let "die2 = $RANDOM % $SPOTS" # 두번째를 굴리면.
  done  

let "throw = $die1 + $die2"
echo "두 주사위를 던진 결과 = $throw"
echo


exit 0