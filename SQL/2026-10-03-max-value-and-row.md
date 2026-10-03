# MAX 값과 그 값을 가진 행 찾기

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
SELECT id, city, points FROM scores WHERE points = (SELECT MAX(points) FROM scores) ORDER BY id;
```

결과(행 배열): `[[4,"Busan",30]]`

MAX(points)는 최댓값 30을 구하며, 바깥 쿼리는 그 값을 가진 행을 찾는다. 최대값을 구한 것과 해당 행의 다른 컬럼을 찾은 것은 별개의 단계다.

## 동점 처리

최댓값이 같은 행이 여러 개면 이 쿼리는 모두 반환한다. 정확히 한 행이 필요하면 동점에서 어떤 행을 선택할지 별도 기준을 정해야 한다. 집계 함수 옆에 id나 city를 그냥 붙여 원하는 행이 선택될 것으로 기대하지 않겠다.

## 참고

- [집계함수 실습](집계함수_예제4.sql)
- [집계함수 점검문제](04_함수2_집계함수_점검문제.sql)
- [MySQL 집계함수 문서](https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html)
