
#!/bin/bash
# RANDOM �� �󸶳� �����Ѱ�?

RANDOM=$$       # ��ũ��Ʈ�� ���μ��� ID �� �Ἥ ���� �ѹ� �߻����� seed�� �ٽ� ����.

PIPS=6          # �ֻ����� ���� 6����.
MAXTHROWS=600   # �ð��� ���� ���� �� ���ڸ� �� �÷�������.
throw=0         # ���� ����.

zeroes=0        # �ʱ�ȭ�� �� �ϸ� 0�� �ƴ϶� ���� �Ǳ� ������
ones=0          # 0���� �ʱ�ȭ �ؾ� �˴ϴ�.
twos=0
threes=0
fours=0
fives=0
sixes=0

print_result ()
{
echo
echo "ones =   $ones"
echo "twos =   $twos"
echo "threes = $threes"
echo "fours =  $fours"
echo "fives =  $fives"
echo "sixes =  $sixes"
echo
}

update_count()
{
case "$1" in
  0) let "ones += 1";;   # �ֻ����� "0"�� �����ϱ� �̰� 1�̶�� �ϰ�
  1) let "twos += 1";;   # �̰� 2��� �ϰ�.... ���..
  2) let "threes += 1";;
  3) let "fours += 1";;
  4) let "fives += 1";;
  5) let "sixes += 1";;
esac
}

echo


while [ "$throw" -lt "$MAXTHROWS" ]
do
  let "die1 = RANDOM % $PIPS"
  update_count $die1
  let "throw += 1"
done  

print_result

# RANDOM �� ���� �����ϴٸ� ��� ������ Ȯ���� ���� ���� ���Դϴ�.
# $MAXTHROWS �� 600 �� ���� ������ 100 ���� 20 ������ ���̸� �ΰ� �л�Ǿ�� �մϴ�.
#
# ������ ���� RANDOM �� �ǻ糭��(pseudorandom) �߻����̱� ������
# ��¥�� ������ ���� �ƴ϶�� ���Դϴ�.

# ���� �������� �ϳ� ������.
# �� ��ũ��Ʈ�� ���� 1000 �� ������ �ɷ� �ٲ㺸����.
# "��"�̳� "��" �߿� �ϳ��� ��������?

exit 0