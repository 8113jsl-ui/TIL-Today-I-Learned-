# COUNT(DISTINCT)로 서로 다른 값 세기

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
SELECT COUNT(city), COUNT(DISTINCT city) FROM scores;
```

결과(행 배열): `[[4,2]]`

도시가 들어 있는 행은 4개지만 서로 다른 도시는 Seoul과 Busan 두 개다. NULL은 두 COUNT에서 모두 제외된다. 고객 수와 고객이 속한 도시 종류 수는 다른 지표이므로 무엇을 세려는지 먼저 정한다.

## 중복 제거의 단위

DISTINCT는 선택한 표현식의 값에 적용된다. 같은 도시의 고객이 여러 명이어도 도시 종류 수는 늘지 않는다. 빈 문자열이 들어 있으면 NULL과는 다른 값이라는 점도 확인해야 한다.

## 참고

- [집계함수 실습](집계함수_예제4.sql)
- [집계함수 점검문제](04_함수2_집계함수_점검문제.sql)
- [MySQL 집계함수 문서](https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html)
