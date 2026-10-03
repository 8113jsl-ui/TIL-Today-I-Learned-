# CASE로 조건에 맞는 행만 합산하기

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
SELECT SUM(CASE WHEN points >= 20 THEN 1 ELSE 0 END), COUNT(CASE WHEN points >= 20 THEN 1 END) FROM scores;
```

결과(행 배열): `[[2,2]]`

20점 이상인 행은 id 2와 4로 두 개다. 첫 표현식은 1과 0을 더하고 두 번째는 조건을 만족한 경우의 1만 센다.

## COUNT에 ELSE 0을 넣으면

COUNT는 0도 NULL이 아닌 값으로 센다. COUNT(CASE ... ELSE 0 END)라고 쓰면 조건에 맞지 않는 행까지 포함된다. SUM과 COUNT를 바꿔 쓸 때 CASE의 반환값도 함께 살펴봐야 한다.

## 참고

- [집계함수 실습](집계함수_예제4.sql)
- [집계함수 점검문제](04_함수2_집계함수_점검문제.sql)
- [MySQL 집계함수 문서](https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html)
