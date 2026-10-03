# 그룹 평균을 다시 평균내면 달라지는 이유

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
SELECT AVG(group_avg), SUM(group_sum)*1.0/SUM(group_count) FROM (SELECT city, AVG(points) AS group_avg, SUM(points) AS group_sum, COUNT(points) AS group_count FROM scores WHERE city IS NOT NULL GROUP BY city) AS grouped;
```

결과(행 배열): `[[22.5,20]]`

Seoul의 유효 점수 평균은 15, Busan은 30이다. 두 평균의 단순 평균은 22.5지만 전체 유효 점수 10·20·30의 평균은 20이다.

## 분모를 같이 보관하기

그룹마다 유효한 값의 개수가 달라서 차이가 생긴다. 전체 평균은 합계의 합을 유효 건수의 합으로 나누어 계산한다. NULL이 있는 자료라면 행 수인 COUNT(*)를 유효 건수로 잘못 사용하지 않도록 주의한다.

## 참고

- [집계함수 실습](집계함수_예제4.sql)
- [집계함수 점검문제](04_함수2_집계함수_점검문제.sql)
- [MySQL 집계함수 문서](https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html)
