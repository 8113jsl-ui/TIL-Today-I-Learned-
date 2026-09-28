# 기본 매개변수와 가변 인자 구분하기

학습일: 2026-09-04

복습 정리일: 2026-09-28

필기에 split과 가변 매개변수를 함께 적어두었습니다. 하지만 결과 항목 수가 달라지는 것과, 함수가 여러 인자를 받는 것은 별개입니다.

## 생략할 수 있는 값과 여러 개의 값

```python
def study_total(*minutes, bonus=0):
    return sum(minutes) + bonus

assert study_total() == 0
assert study_total(10, 20, 30) == 60
assert study_total(10, 20, bonus=5) == 35
assert "Python SQL Web".split(maxsplit=1) == ["Python", "SQL Web"]
```

*minutes는 전달한 위치 인자들을 튜플로 모읍니다. bonus는 여기서 키워드로 전달하며 생략하면 0을 사용합니다. split의 maxsplit은 나눌 횟수를 제한하는 선택 인자예요.

## 기본값에 리스트를 둘 때의 주의점

```python
def record(topic, topics=None):
    if topics is None:
        topics = []
    topics.append(topic)
    return topics

assert record("Python") == ["Python"]
assert record("SQL") == ["SQL"]
existing = ["Web"]
assert record("SQL", existing) is existing
assert existing == ["Web", "SQL"]
```

기본값 표현식은 함수를 정의할 때 평가되므로 topics=[]처럼 쓰면 같은 리스트가 호출 사이에 재사용됩니다. 새 목록이 필요하면 위처럼 함수 안에서 만들어요. 기존 목록을 넘긴 경우에는 원본을 변경한다는 점도 함께 확인합니다.

## 참고

- 2026-09-04 수업 필기 (개인 메모)
- [Python 공식 문서](https://docs.python.org/3/tutorial/controlflow.html#more-on-defining-functions)
