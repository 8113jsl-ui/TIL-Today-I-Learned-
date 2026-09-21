# [Python] floor, ceil, int, round — 음수까지 비교하며 정리하기

원문: [Velog](https://velog.io/@8113jsl-ai/python-floor-ceil-int-round)

Python의 숫자 처리 함수를 복습하면서 수업 필기를 다시 살펴봤어요. 메모에는 floor와 ceil의 결과가 반대로 적혀 있었습니다. 이번에는 공식 문서를 기준으로 바로잡고, 음수까지 넣어보면서 차이를 정리해보려고 해요.

## floor와 ceil, 어느 쪽으로 움직일까요?

math.floor(x)는 x 이하인 정수 중 가장 큰 값을, math.ceil(x)는 x 이상인 정수 중 가장 작은 값을 반환해요. 양수를 넣으면 비교적 익숙한 결과가 나옵니다.

```python
import math

print(math.floor(1.5))  # 1
print(math.ceil(1.5))   # 2
```

여기까지만 보면 소수점을 버리거나 올린다고 외우기 쉬워요. 그런데 음수를 넣으면 방향을 정확히 알아야 합니다.

```python
print(math.floor(-1.5))  # -2
print(math.ceil(-1.5))   # -1
```

수직선에서 -2는 -1.5보다 작고, -1은 -1.5보다 커요. floor는 작은 쪽으로, ceil은 큰 쪽으로 이동한다고 생각하면 이해하기 편합니다. 이미 정수인 값은 그대로예요.

## int도 같은 결과가 나올까요?

실수를 int()로 바꾸면 소수 부분을 제거해요. 즉, 0에 가까운 방향으로 처리합니다.

```python
print(int(1.5))   # 1
print(int(-1.5))  # -1
```

나란히 놓으면 차이가 더 잘 보여요.

| 입력값 | floor | ceil | int |
| --- | ---: | ---: | ---: |
| 1.5 | 1 | 2 | 1 |
| -1.5 | -2 | -1 | -1 |

양수에서는 floor와 int의 결과가 같지만 음수에서는 달라집니다. 문제에서 내림을 요구한다면 무조건 int()를 쓰기보다는 음수 입력이 있는지도 살펴보는 게 좋겠어요.

## 2.5를 반올림했는데 왜 2일까요?

Python의 round()는 가장 가까운 값으로 반올림해요. 두 후보까지의 거리가 정확히 같으면 짝수 쪽을 선택합니다. 정수로 반올림할 때는 이렇게 나와요.

```python
print(round(1.5))  # 2
print(round(2.5))  # 2
print(round(3.5))  # 4
print(round(4.5))  # 4
```

2.5는 2와 3의 정확한 중간이니 짝수인 2가 선택돼요. 그렇다고 정수 부분이 짝수이면 항상 내림하는 것은 아닙니다.

```python
print(round(2.6))  # 3
```

2.6은 3에 더 가까워서 3이 돼요. 짝수 쪽을 고르는 규칙은 정확히 중간인 경우에 적용된다는 점을 기억해두면 좋겠습니다.

## 소수 둘째 자리에서도 한 가지 주의할 점이 있어요

```python
print(round(2.675, 2))  # 2.67
```

2.68을 예상하기 쉽지만 실제 결과는 2.67이에요. 많은 십진 소수가 이진 부동소수점으로 정확하게 표현되지 않기 때문입니다. Python 공식 문서에도 이 예시가 나와 있어요.

반올림 결과가 예상과 다를 때는 함수의 규칙뿐 아니라 컴퓨터 안에 값이 어떻게 저장되는지도 함께 살펴봐야 합니다.

## 문제를 풀 때는 이렇게 구분해보려고 해요

- 주어진 값 이하의 정수가 필요하면 floor
- 주어진 값 이상의 정수가 필요하면 ceil
- 실수의 소수 부분을 제거하려면 int
- 가장 가까운 값으로 반올림하려면 round

본문의 예제는 Python으로 출력 결과를 확인했어요. 비슷해 보이는 함수도 음수와 중간값을 넣으면 차이가 드러나니, 앞으로 숫자를 처리할 때는 어떤 방향으로 값을 바꿔야 하는지 먼저 확인해보려고 합니다.

### 참고한 문서

- [Python 공식 문서: math.floor와 math.ceil](https://docs.python.org/3/library/math.html#math.floor)
- [Python 공식 문서: int](https://docs.python.org/3/library/functions.html#int)
- [Python 공식 문서: round](https://docs.python.org/3/library/functions.html#round)

