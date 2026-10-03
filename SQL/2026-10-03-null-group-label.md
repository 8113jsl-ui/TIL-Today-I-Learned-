# NULL 그룹에 이름을 붙이는 위치

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
SELECT COALESCE(city,'unknown') AS city_label, COUNT(*) FROM scores GROUP BY city ORDER BY city_label;
```

결과(행 배열): `[["Busan",1],["Seoul",3],["unknown",2]]`

도시가 NULL인 두 행은 하나의 그룹을 이룬다. 여기서는 원래 city로 그룹을 만든 뒤 표시할 이름만 바꿨다.

## 치환한 값으로 묶으면

GROUP BY COALESCE(city,'unknown')으로 바꾸면 실제 도시값이 unknown인 행과 NULL인 행이 같은 그룹으로 합쳐질 수 있다. 현재 예제에는 그 값이 없어서 결과가 같지만 일반적으로 동등한 쿼리는 아니다. 표시 이름과 집계 기준을 구분해야 한다.

## 참고

- [집계함수 실습](집계함수_예제4.sql)
- [집계함수 점검문제](04_함수2_집계함수_점검문제.sql)
- [MySQL 집계함수 문서](https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html)
