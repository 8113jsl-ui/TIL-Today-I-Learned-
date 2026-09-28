# set과 딕셔너리 키의 중복 처리

학습일: 2026-09-04

복습 정리일: 2026-09-28

필기의 리스트·set·딕셔너리를 작은 학습 목록으로 비교해 봅니다. 같은 값을 여러 번 기록할지, 한 번만 남길지가 선택 기준이 됩니다.

## 중복을 없애면 순서도 확인해요

```python
topics = ["SQL", "Python", "SQL"]
unique = set(topics)
assert unique == {"SQL", "Python"}
assert len(unique) == 2
assert isinstance({}, dict)
assert isinstance(set(), set)
```

빈 중괄호는 딕셔너리입니다. 빈 set은 set()으로 만들어요. set의 순회 순서를 입력 순서라고 가정하면 안 됩니다.

## 같은 키에 다시 저장하면

```python
minutes = {"SQL": 20}
minutes["SQL"] = 35
assert len(minutes) == 1
assert minutes["SQL"] == 35
assert list(dict.fromkeys(["SQL", "Python", "SQL"])) == ["SQL", "Python"]
```

딕셔너리는 같은 키를 추가하면 해당 값을 갱신합니다. 마지막 예시는 딕셔너리의 삽입 순서를 이용해 처음 등장한 순서로 중복을 제거합니다. 두 자료형 모두 키나 원소에 해시 가능한 값이 필요하며 리스트는 그대로 사용할 수 없습니다.

## 참고

- 2026-09-04 수업 필기 (개인 메모)
- [Python 공식 문서](https://docs.python.org/3/tutorial/datastructures.html#sets)
