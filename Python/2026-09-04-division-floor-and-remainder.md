# /와 //, 음수의 몫과 나머지

학습일: 2026-09-04

복습 정리일: 2026-09-28

필기에는 //의 결과가 int라고 적혀 있었습니다. 실제로는 연산의 의미와 결과 자료형을 따로 살펴볼 필요가 있어요.

## 음수를 넣어 보면 방향이 드러나요

```python
assert 9 / 3 == 3.0
assert 7 // 3 == 2
assert -7 // 3 == -3
assert -7 % 3 == 2
assert -7 == (-7 // 3) * 3 + (-7 % 3)
```

정수끼리 /를 써도 결과는 실수입니다. //는 나눗셈 결과를 작은 정수 쪽으로 내리므로 -7 / 3의 몫은 -3이 됩니다. 단순히 소수 부분을 없애는 int와 구분해야 해요.

## //라고 항상 int는 아니에요

```python
assert isinstance(7 / 3, float)
assert isinstance(7 // 3, int)
assert 7.0 // 3 == 2.0
assert isinstance(7.0 // 3, float)
```

여기서처럼 int와 float를 함께 쓰면 //의 결과도 float입니다. 나누는 수가 0이면 /, //, % 모두 ZeroDivisionError가 발생하므로 입력 조건도 확인합니다.

## 참고

- 2026-09-04 수업 필기 (개인 메모)
- [Python 공식 문서](https://docs.python.org/3/library/stdtypes.html#numeric-types-int-float-complex)
