# Flask 라우팅과 경로 매개변수

학습일: 2026-08-27 · 정리일: 2026-09-24

수업 필기.txt의 해당 날짜 구간을 바탕으로 정리했다. 용어 설명과 예제는 복습을 위해 보완했으며 수업 전체 기록은 아니다.

## URL과 처리 함수를 연결하기

필기에 나온 Flask 예제를 바탕으로 라우팅을 정리한다. 라우팅은 요청의 경로와 메서드 등에 맞는 처리 함수를 연결하는 과정이다. 웹 API를 설명할 때는 보통 메서드와 경로를 함께 적는다.

Flask에서 endpoint라는 내부 용어는 URL 규칙에 연결된 이름을 뜻하며, 기본값은 뷰 함수 이름이다. 일반적인 ‘API 접근 지점’이라는 표현과 구분해 읽는다. [Flask 빠른 시작](https://flask.palletsprojects.com/en/stable/quickstart/)

## 보충 예제

```python
from flask import Flask

app = Flask(__name__)

@app.get("/multiply/<int:a>/<int:b>")
def multiply(a, b):
    return {"result": a * b}

@app.get("/square/<int:n>")
def square(n):
    return {"result": n * n}

with app.test_client() as client:
    assert client.get("/multiply/3/4").get_json() == {"result": 12}
    assert client.get("/square/5").get_json() == {"result": 25}
    assert client.get("/square/abc").status_code == 404
    assert client.post("/square/5").status_code == 405

print("4 cases passed")
```

Flask가 설치된 환경에서 실행한다. 테스트 클라이언트를 사용하므로 외부에 서버를 열지 않는다.

## 결과 해석

`<int:n>`은 경로의 일부를 정수로 변환한다. 숫자가 아닌 경로는 이 규칙과 일치하지 않아 404가 된다. 같은 경로에 POST를 보내면 이 예제는 GET만 허용하므로 405가 된다.

기본 정수 변환기는 음수를 허용하지 않는다. 음수까지 받으려면 변환기 옵션과 입력 범위를 따로 설계해야 한다.

경로 매개변수, 쿼리 매개변수, 요청 본문은 서로 다른 입력 위치다. REST 방식에서도 매개변수를 사용하므로 ‘매개변수 방식과 REST 방식’이 서로 배타적인 것은 아니다.
