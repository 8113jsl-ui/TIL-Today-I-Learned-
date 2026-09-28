# 리스트 컴프리헨션을 풀어서 읽기

학습일: 2026-09-04

복습 정리일: 2026-09-28

필기에 코딩테스트에서 컴프리헨션이 효과적이라는 메모가 있습니다. 무조건 짧게 쓰기보다는 반복문과 같은 흐름인지 비교하며 익혀보려고 해요.

## 조건을 거르고 값을 만들기

```python
minutes = [0, 15, 30, 45]
result = []
for minute in minutes:
    if minute >= 30:
        result.append(minute // 15)

compact = [minute // 15 for minute in minutes if minute >= 30]
assert result == compact == [2, 3]
assert [value for value in []] == []
```

오른쪽의 for에서 값을 꺼내고, if를 통과한 값에 왼쪽 표현식을 적용합니다. 마지막 if는 결과에 넣을 항목을 고르는 조건이에요.

## 모두 남기면서 값만 바꾸려면

```python
labels = ["완료" if minute >= 30 else "진행" for minute in [15, 30]]
assert labels == ["진행", "완료"]
```

여기서 if와 else는 결과값을 고르는 표현식입니다. 조건이 맞지 않는 항목도 결과에 남아요. 컴프리헨션도 결과 리스트를 만들기 위한 메모리가 필요합니다. 조건이나 중첩이 복잡해지면 일반 반복문으로 풀어 쓰겠습니다.

## 참고

- 2026-09-04 수업 필기 (개인 메모)
- [Python 공식 문서](https://docs.python.org/3/tutorial/datastructures.html#list-comprehensions)
