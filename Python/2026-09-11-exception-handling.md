# 예외처리는 오류를 숨기는 일이 아니다

학습일: 2026-09-11

수업에서 예외 상황을 처리해 시스템이 멈추지 않도록 해야 한다고 배웠다. 모든 오류를 무시하기보다 예상한 실패를 적절히 처리하는 것이 중요하다.

## 실패할 수 있는 범위를 좁히기

```python
def parse_minutes(text):
    try:
        minutes = int(text)
    except ValueError:
        return None
    if minutes < 0:
        return None
    return minutes

assert parse_minutes("30") == 30
assert parse_minutes("abc") is None
assert parse_minutes("-1") is None
assert parse_minutes("0") == 0
```

문자열 입력을 가정한 복습용 예시다. 숫자 변환 실패와 음수 입력을 처리하며, 0은 정상값으로 유지한다. 실제 화면에서는 None을 받았을 때 입력 오류를 안내할 수 있다.

## 무조건 계속 실행하면 안 되는 경우

저장에 실패했는데 성공 메시지를 보여 주면 데이터가 누락될 수 있다. 복구할 수 없는 오류는 작업을 중단하고 원인을 남기는 편이 맞을 수 있다.

## 복습한 내용

예외처리는 프로그램을 무조건 계속 돌리는 기술이 아니다. 어떤 실패를 복구하고 어떤 실패를 알릴지 정하는 과정이다. 필요 이상으로 넓은 예외를 잡아 문제를 감추지 않겠다.

## 참고

- 2026-09-11 수업 필기
- [참고 문서](https://docs.python.org/3/tutorial/errors.html)
