# for는 횟수보다 꺼낼 대상을 먼저 봐요

학습일: 2026-09-04

복습 정리일: 2026-09-28

필기에는 for를 반복 횟수가 정해졌을 때 사용하는 문법으로 정리했습니다. Python에서는 반복 가능한 대상에서 항목을 하나씩 꺼낸다고 이해하면 적용 범위가 더 분명해져요.

## 목록의 값을 바로 사용하기

```python
topics = ["Python", "SQL", "Web"]
lengths = []
for topic in topics:
    lengths.append(len(topic))
assert lengths == [6, 3, 3]
```

값만 필요하면 인덱스를 먼저 만들 필요가 없습니다. 리스트 외에도 문자열이나 다른 반복 가능한 객체를 순회할 수 있어요.

## 숫자 순서가 필요하면 range

```python
assert list(range(2, 8, 2)) == [2, 4, 6]
assert list(range(3, 0, -1)) == [3, 2, 1]
assert list(range(0)) == []
assert list(enumerate(["Python", "SQL"], start=1)) == [(1, "Python"), (2, "SQL")]
```

끝값은 포함하지 않습니다. 번호와 값이 모두 필요하면 enumerate도 사용할 수 있어요. 반복 도중 같은 리스트에서 항목을 삭제하기보다는 새 결과 목록을 만드는 방식을 먼저 고려하겠습니다.

## 참고

- 2026-09-04 수업 필기 (개인 메모)
- [Python 공식 문서](https://docs.python.org/3/tutorial/controlflow.html#for-statements)
