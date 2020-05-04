#!/bin/bash
# seeding-random.sh: RANDOM ������ seed ����.

MAXCOUNT=25       # �߻���ų ���� ����.

random_numbers ()
{
count=0
while [ "$count" -lt "$MAXCOUNT" ]
do
  number=$RANDOM
  echo -n "$number "
  let "count += 1"
done  
}

echo; echo

RANDOM=1          # ���� �ѹ� �߻��⿡ RANDOM seed ����.
random_numbers

echo; echo

RANDOM=1          # �Ȱ��� seed ���....
random_numbers    # ... ������ �Ȱ��� ������ �߻�.

echo; echo

RANDOM=2          # �ٸ� seed �� ��õ�...
random_numbers    # �ٸ� ���� �߻�.

echo; echo

# RANDOM=$$  ��� �ϴ� ���� RANDOM �� ��ũ��Ʈ�� ���μ��� ID�� seed�� �����ϴ� ���Դϴ�.
# 'time' �̳� 'date'�� �� ���� �ְڳ׿�.

# �� ������ �� ����.
SEED=$(head -1 /dev/urandom | od -N 1 | awk '{ print $2 }')
# /dev/urandom(�ý��ۿ��� �����ϴ� �ǻ糭�� "����̽�")���� ���� �ǻ糭��
# �� ���� "od"�� �̿��ؼ� ��� ������(8����) ���ڷ� �̷���� �ٷ� ��ȯ.
# ���������� "awk"�� �Ἥ SEED ���� �� �� ���� ���ڸ� �̾Ƴ�.
RANDOM=$SEED
random_numbers

echo; echo

exit 0