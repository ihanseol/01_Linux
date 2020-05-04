#!/bin/bash

# $RANDOM �� �Ҹ� ������ �ٸ� ������ ���� ���� �����մϴ�.
# ��Ī���� ����(nominal range): 0 - 32767(16 ��Ʈ ���� ����).

MAXCOUNT=10
count=1

echo
echo "$MAXCOUNT ���� ������ ����:"
echo "-----------------"
while [ "$count" -le $MAXCOUNT ]      # 10 ($MAXCOUNT) ���� ���� ���� �߻�.
do
  number=$RANDOM
  echo $number
  let "count += 1"  # ī���� ����.
done
echo "-----------------"

# � ������ ���� ���� �ʿ��ϴٸ� '������(modulo)' �����ڸ� ����,
# � ���� ���� ������ ���� ������ �ݴϴ�.

RANGE=500

echo

number=$RANDOM
let "number %= $RANGE"
echo "$RANGE ���� ���� ������ ����  ---  $number"

echo

# � ������ ū ������ ������ �ʿ��ϴٸ� 
# �� ������ ���� ���� �����ϴ� �׽�Ʈ ���� �ɸ� �˴ϴ�.

FLOOR=200

number=0   # �ʱ�ȭ
while [ "$number" -le $FLOOR ]
do
  number=$RANDOM
done
echo "$FLOOR ���� ū ������ ����  ---  $number"
echo


# ���Ѱ��� ���Ѱ� ������ ���� �ʿ��ϴٸ� ���� �� ��ũ���� ���� ���� �˴ϴ�.
number=0   # �ʱ�ȭ
while [ "$number" -le $FLOOR ]
do
  number=$RANDOM
  let "number %= $RANGE"  # $number �� $RANGE �ȿ� ������.
done
echo "$FLOOR �� $RANGE ������ ������ ����  ---  $number"
echo


# "��"�̳� "����"�߿� �ϳ��� ������ �� ���� �ֽ��ϴ�.
BINARY=2
number=$RANDOM
T=1

let "number %= $BINARY"
# let "number >>= 14"    �� ���� ������ �������� �ݴϴ�.
# (������ �� ��Ʈ�� �����ϰ� ��� ���������� ����Ʈ ��Ŵ).
if [ "$number" -eq $T ]
then
  echo "TRUE"
else
  echo "FALSE"
fi  

echo


# �ֻ��� �����⸦ �䳻�� �����?
SPOTS=7   # 7 �� ������(modulo)�� 0 - 6.
DICE=2
ZERO=0
die1=0
die2=0

# ��Ȯ�� Ȯ���� ���ؼ� �� ���� �ֻ����� ���� �����ô�.

  while [ "$die1" -eq $ZERO ]     # �ֻ����� 0�� ����.
  do
    let "die1 = $RANDOM % $SPOTS" # ù��° �ֻ����� ������.
  done  

  while [ "$die2" -eq $ZERO ]
  do
    let "die2 = $RANDOM % $SPOTS" # �ι�°�� ������.
  done  

let "throw = $die1 + $die2"
echo "�� �ֻ����� ���� ��� = $throw"
echo


exit 0