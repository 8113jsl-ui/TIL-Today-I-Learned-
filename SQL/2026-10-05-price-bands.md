# 모든 가격대가 저가로 나오는 CASE 고치기

복습 정리일: 2026-10-05 (원래 수업일이 아님)

도서 주문 SQL 실습을 작은 가상 데이터로 재구성했다. 아래 쿼리는 **SQLite용**이며, 원본 MySQL 문법과의 차이를 구분한다.

## 실행 예제

```sql
SELECT price, CASE WHEN price IS NULL THEN 'unknown' WHEN price<15000 THEN 'low' WHEN price<=25000 THEN 'middle' ELSE 'high' END AS band FROM (SELECT 14999 AS price UNION ALL SELECT 15000 UNION ALL SELECT 25000 UNION ALL SELECT 25001) ORDER BY price;
```

예상 결과(행 배열): `[[14999,"low"],[15000,"middle"],[25000,"middle"],[25001,"high"]]`

원본 실습은 세 분기의 반환값이 모두 '저가'였다. 복습에서는 15,000원 미만을 저가, 25,000원 이하를 중가, 그 초과를 고가로 정해 구분했다.

## 조건과 반환값을 함께 검토

CASE는 앞에서 참이 된 분기를 사용하므로 두 번째 분기는 앞 조건을 통과하지 않은 값에 적용된다. 조건식이 서로 달라도 반환값이 같으면 화면에서 차이를 볼 수 없다. 각 구간에 실제로 다른 결과가 나오는지 확인해야 한다.

## 참고

- [원본 도서 실습](day2%20실습문제.sql)
- [SQLite 참고 문서](https://www.sqlite.org/lang_expr.html)
