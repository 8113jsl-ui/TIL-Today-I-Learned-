# 재고 분류는 4·5·29·30에서 확인하기

복습 정리일: 2026-10-05 (원래 수업일이 아님)

도서 주문 SQL 실습을 작은 가상 데이터로 재구성했다. 아래 쿼리는 **SQLite용**이며, 원본 MySQL 문법과의 차이를 구분한다.

## 실행 예제

```sql
SELECT stock, CASE WHEN stock IS NULL THEN 'unknown' WHEN stock < 5 THEN 'low' WHEN stock >=30 THEN 'enough' ELSE 'normal' END AS grade FROM (SELECT 4 AS stock UNION ALL SELECT 5 UNION ALL SELECT 29 UNION ALL SELECT 30 UNION ALL SELECT NULL) ORDER BY stock;
```

예상 결과(행 배열): `[[null,"unknown"],[4,"low"],[5,"normal"],[29,"normal"],[30,"enough"]]`

품절입박은 5 미만, 충분은 30 이상으로 정했다. 바로 앞뒤 값인 4·5와 29·30을 넣으면 경계에서 분류가 잘못되는지 쉽게 확인할 수 있다.

## 잘못된 입력은 별도 정책

NULL을 보통 재고로 분류하지 않도록 별도 분기를 두었다. 음수 재고를 허용할지는 이 분류식 밖에서 결정해야 한다. CASE 결과가 나온다는 사실만으로 원본 데이터가 정상이라고 판단하면 안 된다.

## 참고

- [원본 도서 실습](day2%20실습문제.sql)
- [SQLite 참고 문서](https://www.sqlite.org/lang_expr.html)
