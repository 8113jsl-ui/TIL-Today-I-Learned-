# 경과일 계산은 기준일을 고정해서 검증하기

복습 정리일: 2026-10-05 (원래 수업일이 아님)

도서 주문 SQL 실습을 작은 가상 데이터로 재구성했다. 아래 쿼리는 **SQLite용**이며, 원본 MySQL 문법과의 차이를 구분한다.

## 실행 예제

```sql
SELECT pub_date, CAST(JULIANDAY('2026-10-05')-JULIANDAY(pub_date) AS INTEGER) AS elapsed_days FROM (SELECT '2026-10-01' AS pub_date UNION ALL SELECT '2026-10-05' UNION ALL SELECT '2026-10-06') ORDER BY pub_date;
```

예상 결과(행 배열): `[["2026-10-01",4],["2026-10-05",0],["2026-10-06",-1]]`

기준일보다 나흘 전은 4, 당일은 0, 다음 날은 -1이다. 원본의 현재 날짜 기반 계산을 고정된 기준일로 바꿔 결과가 실행 날짜에 따라 달라지지 않게 했다.

## 날짜와 시각 구분

예제는 시각 없는 유효한 날짜만 사용한다. 원본 MySQL DATEDIFF와 SQLite JULIANDAY 차이를 모든 시각 입력에서 같다고 보면 안 된다. 서비스에서는 달력 날짜 차이인지 실제 경과 시간인지 먼저 정한다.

## 참고

- [원본 도서 실습](day2%20실습문제.sql)
- [SQLite 참고 문서](https://www.sqlite.org/lang_datefunc.html)
