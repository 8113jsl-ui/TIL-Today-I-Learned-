# 문자열과 숫자를 함께 다룰 때

학습일: 2026-09-04

복습 정리일: 2026-09-28

필기의 자료형과 문자열 연결 부분을 복습합니다. 같은 숫자 모양이라도 문자열인지 숫자인지에 따라 +의 동작이 달라져요.

## 더하기 전에 자료형부터 확인해요

```python
text = "12"
assert text + "3" == "123"
assert int(text) + 3 == 15
assert "학습 시간: " + str(15) == "학습 시간: 15"
```

숫자로 계산하려면 int 등으로 변환하고, 문장으로 보여줄 때는 str이나 f-string을 사용할 수 있습니다. 문자열과 정수를 그대로 더하면 TypeError가 납니다. 숫자 형태가 아닌 문자열은 int로 바꿀 수 없어요.

## 문자열은 수정 가능한 문자 리스트가 아니에요

```python
word = "code"
assert word[0] == "c"
changed = "C" + word[1:]
assert changed == "Code"
assert word == "code"
```

문자열에는 인덱싱을 할 수 있지만 word[0]에 새 문자를 대입할 수는 없습니다. 위 예시는 새 문자열을 만들어 changed에 저장합니다. 문자열을 리스트처럼 설명한 필기는 이 차이를 함께 적어두면 좋겠어요.

## 참고

- 2026-09-04 수업 필기 (개인 메모)
- [Python 공식 문서](https://docs.python.org/3/library/stdtypes.html#text-sequence-type-str)
