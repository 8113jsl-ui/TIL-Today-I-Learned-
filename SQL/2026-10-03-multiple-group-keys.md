# 두 컬럼으로 그룹의 단위를 정하기

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
SELECT city, role, COUNT(*) FROM scores WHERE city IS NOT NULL GROUP BY city, role ORDER BY city, role;
```

결과(행 배열): `[["Busan","A",1],["Seoul","A",2],["Seoul","B",1]]`

도시별이 아니라 도시와 역할의 조합별로 세므로 Seoul도 A와 B로 나뉜다. GROUP BY에 컬럼을 추가하면 결과 행의 의미가 달라진다.

## 한 행이 무엇을 뜻하는가

원본 실습의 담당자직위·도시 묶음을 단순화한 예시다. 도시만으로 집계한 결과와 비교할 때 그룹 수가 늘었다고 원본 데이터가 늘어난 것은 아니다. 보고서의 한 행이 어떤 단위인지 제목과 열 이름에 드러내겠다.

## 참고

- [집계함수 실습](집계함수_예제4.sql)
- [집계함수 점검문제](04_함수2_집계함수_점검문제.sql)
- [MySQL 집계함수 문서](https://dev.mysql.com/doc/refman/8.4/en/aggregate-functions.html)
