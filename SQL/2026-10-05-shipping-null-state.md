# 미발송을 정상 배송으로 분류하지 않기

복습 정리일: 2026-10-05 (원래 수업일이 아님)

도서 주문 SQL 실습을 작은 가상 데이터로 재구성했다. 아래 쿼리는 **SQLite용**이며, 원본 MySQL 문법과의 차이를 구분한다.

## 실행 예제

```sql
SELECT id, CASE WHEN ship_date IS NULL THEN 'pending' WHEN JULIANDAY(ship_date)-JULIANDAY(request_date)>=3 THEN 'late' ELSE 'normal' END AS state FROM (SELECT 1 AS id,'2026-10-01' AS request_date,'2026-10-03' AS ship_date UNION ALL SELECT 2,'2026-10-01','2026-10-04' UNION ALL SELECT 3,'2026-10-01',NULL) ORDER BY id;
```

예상 결과(행 배열): `[[1,"normal"],[2,"late"],[3,"pending"]]`

요청일에서 발송일까지 3일 이상이면 지연이라고 정한 예시다. 발송일이 없는 행은 지연 비교 전에 미발송으로 구분했다.

## 누락과 업무 상태

NULL 날짜의 비교 결과가 참이 아니라고 정상 배송으로 처리하면 안 된다. 요청일이 반드시 존재한다는 예제의 전제도 확인해야 한다. 실제로 아직 안 보낸 주문의 지연 여부까지 판단하려면 기준일과 별도 규칙이 필요하다.

## 참고

- [원본 도서 실습](day2%20실습문제.sql)
- [SQLite 참고 문서](https://www.sqlite.org/lang_datefunc.html)
