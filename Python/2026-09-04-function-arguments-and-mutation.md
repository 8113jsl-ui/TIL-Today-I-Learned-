# 함수에 넘긴 리스트가 바뀌는 이유

학습일: 2026-09-04

복습 정리일: 2026-09-28

함수 부분에 적어둔 Call by Value라는 표현만으로는 Python의 동작을 설명하기 어렵습니다. 전달된 객체를 변경하는 경우와 매개변수에 새 객체를 대입하는 경우를 나눠 봅니다.

## 객체를 변경하면 호출한 곳에서도 보여요

```python
def add_record(records):
    records.append(30)

history = [10, 20]
result = add_record(history)
assert history == [10, 20, 30]
assert result is None
```

매개변수 records는 전달된 리스트와 같은 객체를 가리킵니다. append가 그 객체를 변경하므로 history로도 변경 내용을 볼 수 있어요. 명시적인 반환이 없는 함수의 반환값은 None입니다.

## 매개변수의 재대입은 달라요

```python
def replace_record(records):
    records = [99]
    return records

history = [10, 20]
new_history = replace_record(history)
assert history == [10, 20]
assert new_history == [99]
```

함수 안의 재대입은 지역 이름 records의 연결을 바꿉니다. 호출한 쪽의 이름을 새 리스트에 연결하지는 않아요. 함수 설명에도 원본을 변경하는지 새 값을 반환하는지 구분해서 적어두겠습니다.

## 참고

- 2026-09-04 수업 필기 (개인 메모)
- [Python 공식 문서](https://docs.python.org/3/tutorial/controlflow.html#defining-functions)
