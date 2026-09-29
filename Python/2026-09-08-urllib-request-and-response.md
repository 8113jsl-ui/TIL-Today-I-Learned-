# urllib에서 요청과 응답 본문 구분하기

학습일: 2026-09-08

수업에서 urlopen으로 URL을 여는 코드를 배웠다. 요청을 만드는 객체, 응답 객체, 응답 본문은 서로 다른 단계다.

## 요청 객체 만들기

```python
from urllib.request import Request

request = Request("https://example.com/", method="GET")
assert request.get_method() == "GET"
assert request.full_url == "https://example.com/"
```

이 코드는 요청 객체만 만들며 네트워크 요청을 보내지는 않는다. 실제 연결에는 urlopen을 사용한다. 아래는 외부 서버가 필요 없는 복습용 본문 읽기 예시다.

```python
from urllib.request import urlopen

with urlopen("data:text/plain;charset=utf-8,hello") as response:
    body = response.read()
assert body == b"hello"
assert body.decode("utf-8") == "hello"
```

## 본문은 바로 문자열이 아니다

read로 읽은 바이트를 텍스트로 사용할 때는 올바른 인코딩으로 해석해야 한다. 모든 응답을 UTF-8이라고 가정하기보다 응답 형식과 헤더를 확인한다.

실제 HTTP 요청에서는 타임아웃과 연결 오류, HTTP 오류도 처리해야 한다. data URL 예시는 통신 성공이나 서버 상태 코드를 검증하는 실습은 아니다.

## 복습한 내용

URL을 열었다는 것과 HTML 또는 JSON을 해석했다는 것은 다르다. 연결, 읽기, 디코딩, 데이터 해석을 구분하겠다.

## 참고

- 2026-09-08 수업 필기
- [참고 문서](https://docs.python.org/3/library/urllib.request.html)
