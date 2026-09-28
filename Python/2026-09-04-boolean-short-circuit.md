# and와 or가 돌려주는 값 살펴보기

학습일: 2026-09-04

복습 정리일: 2026-09-28

필기에 비교 연산자와 논리 연산자를 따로 적어두었습니다. 비교 결과는 보통 True나 False로 만나지만, and와 or는 피연산자 자체를 반환할 수 있어요.

## 기본값을 고를 때 생기는 차이

```python
assert ("" or "미입력") == "미입력"
assert ("Python" and 30) == 30
minutes = 0
assert (minutes or 25) == 25
assert (25 if minutes is None else minutes) == 0
```

0도 거짓으로 취급되므로 or로 기본값을 정하면 유효한 0까지 바뀔 수 있습니다. 값이 없는 경우를 None으로 정했다면 is None으로 구분하는 편이 의도에 맞아요.

## 뒤쪽 계산을 생략할 수 있어요

```python
calls = []
def check():
    calls.append("called")
    return True

assert (False and check()) is False
assert (True or check()) is True
assert calls == []
```

앞쪽 값만으로 결정되면 뒤쪽 표현식은 평가하지 않습니다. 이를 단락 평가라고 하며, 함수가 항상 호출될 거라고 가정하면 놓치는 동작이 생길 수 있어요.

## 참고

- 2026-09-04 수업 필기 (개인 메모)
- [Python 공식 문서](https://docs.python.org/3/library/stdtypes.html#boolean-operations-and-or-not)
