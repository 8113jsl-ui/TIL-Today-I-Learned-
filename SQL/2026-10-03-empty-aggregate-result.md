# 집계 대상이 없을 때 SUM과 COUNT

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
SELECT COUNT(*), SUM(points), COALESCE(SUM(points),0) FROM scores WHERE id < 0;
```

결과(행 배열): `[[0,null,0]]`

조건에 맞는 행이 없으면 COUNT(*)는 0, SUM(points)는 NULL이다. COALESCE로 합계의 NULL을 0으로 바꿀 수 있다.

## 행이 없다는 사실 보존하기

GROUP BY가 없는 이 쿼리는 집계 결과 한 행을 반환한다. 그룹별 집계에서 그룹 자체가 없는 경우와는 다르다. 합계만 0으로 표시하면 실제 합이 0인 경우와 자료가 없는 경우를 구분하지 못하므로 건수도 함께 확인하겠다.

## 참고

- [집계함수 실습](집계함수_예제4.sql)
- [집계함수 점검문제](04_함수2_집계함수_점검문제.sql)
- [MySQL 집계함수 문서](https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html)
