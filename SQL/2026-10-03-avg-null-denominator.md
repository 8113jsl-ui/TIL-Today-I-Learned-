# AVG에서 NULL을 0으로 바꿀 때

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
SELECT AVG(points), AVG(COALESCE(points, 0)) FROM scores;
```

결과(행 배열): `[[15,10]]`

값이 있는 네 행의 합은 60이므로 AVG(points)는 15다. NULL을 0으로 바꾸면 여섯 행이 분모에 들어가 평균이 10이 된다.

## 결측과 0의 의미

측정하지 않은 값을 0으로 치환하면 지표의 의미가 바뀐다. COALESCE는 보기 좋게 표시하는 용도로만 작동하는 것이 아니다. 집계 안에서 사용하면 계산에 참여하는 값과 분모가 달라질 수 있다.

## 참고

- [집계함수 실습](집계함수_예제4.sql)
- [집계함수 점검문제](04_함수2_집계함수_점검문제.sql)
- [MySQL 집계함수 문서](https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html)
