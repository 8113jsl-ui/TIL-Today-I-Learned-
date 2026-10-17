# LIKE에서 퍼센트 기호 자체 검색하기

정리일: 2026-10-18

수업 필기에서 확장한 추가 학습이다. 아래 데이터는 동작 확인을 위한 자체 예제이며 SQLite 기준이다.

## 확인할 내용

와일드카드가 아닌 실제 % 문자가 있는 문자열을 찾는다.

## 실행 예제

각 예제는 테이블 생성 없이 독립적으로 실행할 수 있다.

```sql
WITH labels(txt) AS (VALUES ('10% sale'), ('100 sale'), ('%'))
SELECT txt FROM labels WHERE txt LIKE '%!%%' ESCAPE '!' ORDER BY txt;
```

결과(행별 배열, null은 SQL NULL):

```json
[
  [
    "%"
  ],
  [
    "10% sale"
  ]
]
```

## 정리

앞뒤 %는 임의의 문자열이고 !%는 실제 퍼센트 기호다. ESCAPE 문자를 정했으면 그 문자 자체를 찾는 경우도 별도로 이스케이프해야 한다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_expr.html)
