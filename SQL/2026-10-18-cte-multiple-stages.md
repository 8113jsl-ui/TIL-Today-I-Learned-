# 여러 CTE로 필터와 집계를 분리하기

정리일: 2026-10-18

수업 필기에서 확장한 추가 학습이다. 아래 데이터는 동작 확인을 위한 자체 예제이며 SQLite 기준이다.

## 확인할 내용

취소 건을 제외한 다음 합계를 구하는 순서를 쿼리에 드러낸다.

## 실행 예제

각 예제는 테이블 생성 없이 독립적으로 실행할 수 있다.

```sql
WITH orders(team, amount, state) AS (
  VALUES ('A', 20, 'paid'), ('A', 90, 'cancelled'), ('B', 40, 'paid')
), paid AS (
  SELECT team, amount FROM orders WHERE state = 'paid'
), totals AS (
  SELECT team, SUM(amount) AS total FROM paid GROUP BY team
)
SELECT team, total FROM totals ORDER BY team;
```

결과(행별 배열, null은 SQL NULL):

```json
[
  [
    "A",
    20
  ],
  [
    "B",
    40
  ]
]
```

## 정리

필터를 집계보다 앞에 두어 취소 금액이 합계에 들어가지 않게 했다. 같은 조건을 여러 곳에 복사하기보다 단계마다 담당하는 일을 확인한다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_with.html)
