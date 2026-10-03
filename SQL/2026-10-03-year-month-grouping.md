# 월별 집계에서 연도를 빠뜨리지 않기

복습 정리일: 2026-10-03 (원래 수업일이 아님)

저장소의 집계함수 실습을 바탕으로 만든 가상 데이터 예제다. 공통 SQL 문법의 결과는 SQLite에서 확인했다. MySQL 전용 동작은 별도로 구분한다.

## 예제 데이터

```sql
CREATE TABLE scores (id INTEGER, city TEXT, role TEXT, points INTEGER);
INSERT INTO scores VALUES
(1,'Seoul','A',10),(2,'Seoul','A',20),
(3,'Seoul','B',NULL),(4,'Busan','A',30),
(5,NULL,'B',0),(6,NULL,'B',NULL);
```

## 확인할 쿼리

```sql
SELECT SUBSTR(ordered_on,1,7) AS year_month, COUNT(*) FROM (SELECT '2025-01-10' AS ordered_on UNION ALL SELECT '2026-01-10' UNION ALL SELECT '2026-02-01') AS orders GROUP BY SUBSTR(ordered_on,1,7) ORDER BY year_month;
```

결과(행 배열): `[["2025-01",1],["2026-01",1],["2026-02",1]]`

1월이라는 월 번호만 묶으면 서로 다른 해의 1월이 합쳐진다. 예제는 YYYY-MM-DD 형식이 보장된 문자열에서 연월을 추출해 구분했다.

## 날짜 타입과 기간 확인

실제 MySQL DATE 컬럼을 다룬다면 YEAR와 MONTH 등 날짜 함수를 사용할 수 있다. 이 문자열 예제를 임의 형식의 날짜나 시간대 변환에 그대로 적용하면 안 된다. 월별 추이를 볼지 여러 해의 계절성을 볼지 목적에 따라 그룹 기준을 정한다.

## 참고

- [집계함수 실습](집계함수_예제4.sql)
- [집계함수 점검문제](04_함수2_집계함수_점검문제.sql)
- [MySQL 집계함수 문서](https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html)
