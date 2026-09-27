# lambda와 정렬 기준 함수

학습일: 2026-09-08

수업에서 함수를 간단히 표현하는 lambda를 배웠다. 필기의 화살표 표기는 Python 문법과 다르므로 실제 문법으로 정리했다.

## 하나의 표현식으로 함수 만들기

Python의 lambda는 lambda 매개변수: 표현식 형태다. 표현식의 값이 반환된다. 여러 문장이 필요하면 def로 함수를 정의하는 편이 적합하다.

```python
tasks = [("Python", 30), ("SQL", 15), ("Web", 25)]
ordered = sorted(tasks, key=lambda item: item[1])
assert ordered == [("SQL", 15), ("Web", 25), ("Python", 30)]
assert tasks[0] == ("Python", 30)
```

복습용 예시는 각 튜플의 두 번째 값인 공부 시간을 기준으로 정렬한다. sorted는 새 리스트를 반환하며 원래 리스트를 직접 정렬하지 않는다.

## 한 번만 쓸 수 있는가

lambda가 만든 함수도 다른 함수처럼 전달하거나 저장할 수 있다. 일회성으로 쓰기 편하다는 것과 한 번만 실행할 수 있다는 것은 다르다.

## 복습한 내용

짧은 기준 함수를 넘길 때 lambda가 유용하다. 하지만 조건이 길어지거나 설명이 필요하면 이름 있는 함수를 만들어 의도를 드러내는 편이 읽기 쉽다.

## 참고

- 2026-09-08 수업 필기
- [참고 문서](https://docs.python.org/3/tutorial/controlflow.html)
