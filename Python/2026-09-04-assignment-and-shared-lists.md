# 변수 대입과 리스트 복사 구분하기

학습일: 2026-09-04

복습 정리일: 2026-09-28

필기의 변수 재할당 내용을 복습하면서, 이름을 바꾸는 일과 객체를 바꾸는 일을 작은 리스트로 비교해 봅니다.

## 두 이름이 같은 리스트를 가리킬 때

```python
original = [10, 20]
alias = original
alias.append(30)
assert original == [10, 20, 30]
assert alias is original

alias = [99]
assert original == [10, 20, 30]
assert alias == [99]
```

처음 대입은 리스트를 복제하지 않습니다. 그래서 append의 결과를 두 이름으로 모두 볼 수 있어요. 이후 alias에 새 리스트를 대입하면 alias가 가리키는 대상만 달라집니다.

## 바깥 리스트만 복사하면

```python
original = [[10], [20]]
copied = original.copy()
copied.append([30])
assert len(original) == 2
copied[0].append(15)
assert original[0] == [10, 15]
```

copy는 얕은 복사여서 안쪽 리스트는 공유합니다. 중첩 데이터를 수정할 때는 어느 깊이까지 독립적으로 만들어야 하는지 먼저 확인해야겠어요.

## 참고

- 2026-09-04 수업 필기 (개인 메모)
- [Python 공식 문서](https://docs.python.org/3/library/copy.html)
