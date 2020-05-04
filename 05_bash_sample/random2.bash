
#!/bin/bash
# RANDOM 이 얼마나 랜덤한가?

RANDOM=$$       # 스크립트의 프로세스 ID 를 써서 랜덤 넘버 발생기의 seed를 다시 생성.

PIPS=6          # 주사위는 눈이 6개죠.
MAXTHROWS=600   # 시간이 남아 돌면 이 숫자를 더 늘려보세요.
throw=0         # 던진 숫자.

zeroes=0        # 초기화를 안 하면 0이 아니라 널이 되기 때문에
ones=0          # 0으로 초기화 해야 됩니다.
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
  0) let "ones += 1";;   # 주사위에 "0"이 없으니까 이걸 1이라고 하고
  1) let "twos += 1";;   # 이걸 2라고 하고.... 등등..
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

# RANDOM 이 정말 랜덤하다면 결과 분포는 확실히 고르게 나올 것입니다.
# $MAXTHROWS 가 600 일 때는 각각은 100 에서 20 정도의 차이를 두고 분산되어야 합니다.
#
# 주의할 것은 RANDOM 이 의사난수(pseudorandom) 발생기이기 때문에
# 진짜로 랜덤한 것은 아니라는 점입니다.

# 쉬운 연습문제 하나 낼께요.
# 이 스크립트를 동전 1000 번 뒤집는 걸로 바꿔보세요.
# "앞"이나 "뒤" 중에 하나가 나오겠죠?

exit 0