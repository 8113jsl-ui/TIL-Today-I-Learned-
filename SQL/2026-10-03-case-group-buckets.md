# CASE 분류에서 미입력 값을 따로 남기기

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
SELECT CASE WHEN points IS NULL THEN 'missing' WHEN points >= 20 THEN 'high' ELSE 'low' END AS bucket, COUNT(*) FROM scores GROUP BY CASE WHEN points IS NULL THEN 'missing' WHEN points >= 20 THEN 'high' ELSE 'low' END ORDER BY bucket;
```

결과(행 배열): `[["high",2],["low",2],["missing",2]]`

높은 점수, 낮은 점수, 미입력이 각각 두 행이다. NULL 비교는 참이 아니므로 미입력 분기를 생략하면 ELSE에 섞일 수 있다.

## 분류 기준을 먼저 정하기

수업의 VIP·일반고객 구분 예제를 작은 점수 구간으로 바꿨다. 경계값 20을 어느 구간에 넣는지, 결측값을 분류할 수 있는지 먼저 결정한다. SELECT와 GROUP BY에는 같은 분류식을 사용했다.

## 참고

- [집계함수 실습](집계함수_예제4.sql)
- [집계함수 점검문제](04_함수2_집계함수_점검문제.sql)
- [MySQL 집계함수 문서](https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html)
