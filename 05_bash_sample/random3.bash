#!/bin/bash
# seeding-random.sh: RANDOM 변수에 seed 적용.

MAXCOUNT=25       # 발생시킬 숫자 갯수.

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

RANDOM=1          # 랜덤 넘버 발생기에 RANDOM seed 세팅.
random_numbers

echo; echo

RANDOM=1          # 똑같은 seed 사용....
random_numbers    # ... 완전히 똑같은 수열이 발생.

echo; echo

RANDOM=2          # 다른 seed 로 재시도...
random_numbers    # 다른 수열 발생.

echo; echo

# RANDOM=$$  라고 하는 것은 RANDOM 에 스크립트의 프로세스 ID로 seed를 세팅하는 것입니다.
# 'time' 이나 'date'로 할 수도 있겠네요.

# 더 멋지게 해 보죠.
SEED=$(head -1 /dev/urandom | od -N 1 | awk '{ print $2 }')
# /dev/urandom(시스템에서 제공하는 의사난수 "디바이스")에서 얻은 의사난수
# 그 다음 "od"를 이용해서 출력 가능한(8진수) 숫자로 이루어진 줄로 변환.
# 마지막으로 "awk"를 써서 SEED 에서 쓸 한 개의 숫자를 뽑아냄.
RANDOM=$SEED
random_numbers

echo; echo

exit 0