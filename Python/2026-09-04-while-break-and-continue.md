# while에서 종료와 건너뛰기 구분하기

학습일: 2026-09-04

복습 정리일: 2026-09-28

필기에 break는 종료, continue는 처음으로 돌아가기라고 적었습니다. continue 이후에 어떤 문장이 생략되는지 예제로 확인해 봅니다.

## 반복을 건너뛰기 전에 값 갱신하기

```python
number = 0
selected = []
while number < 6:
    number += 1
    if number % 2 == 0:
        continue
    selected.append(number)
assert selected == [1, 3, 5]
```

continue를 만나면 현재 반복의 남은 부분을 생략하고 조건을 다시 확인합니다. number를 늘리는 문장을 continue 뒤에 두면 특정 값에서 계속 멈춰 있을 수 있어요.

## 원하는 값을 찾으면 종료하기

```python
found = None
for value in [3, 7, 12, 20]:
    if value >= 10:
        found = value
        break
assert found == 12
```

break는 가장 안쪽 반복문 하나를 끝냅니다. while은 조건이 거짓이 될 때도 종료되므로 반드시 break가 있어야 하는 것은 아닙니다. 종료 조건과 상태가 바뀌는 위치를 함께 읽는 습관을 들이려고 해요.

## 참고

- 2026-09-04 수업 필기 (개인 메모)
- [Python 공식 문서](https://docs.python.org/3/tutorial/controlflow.html#break-and-continue-statements)
