# WITH로 조회 단계에 이름 붙이기

정리일: 2026-10-18

수업 필기에서 확장한 추가 학습이다. 아래 데이터는 동작 확인을 위한 자체 예제이며 SQLite 기준이다.

## 확인할 내용

집계 결과에 이름을 붙이면 최종 조회에서 조건의 의미를 읽기 쉽다.

## 실행 예제

각 예제는 테이블 생성 없이 독립적으로 실행할 수 있다.

```sql
WITH sales(team, amount) AS (VALUES ('A', 30), ('A', 50), ('B', 20)),
totals AS (SELECT team, SUM(amount) AS total FROM sales GROUP BY team)
SELECT team, total FROM totals WHERE total >= 60 ORDER BY team;
```

결과(행별 배열, null은 SQL NULL):

```json
[
  [
    "A",
    80
  ]
]
```

## 정리

totals는 이 문장에서만 참조할 수 있다. 영구 테이블이 생기는 것은 아니며, CTE 사용 자체가 성능 향상을 보장하지도 않는다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_with.html)
