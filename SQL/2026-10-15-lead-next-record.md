# LEAD로 다음 기록과 현재 기록 비교하기

추가 학습 정리일: 2026-10-15

기존 SQL 윈도 함수 학습에서 확장한 자체 예제다. 수업에서 실제로 다룬 내용이라고 단정하지 않는다. 아래 결과는 SQLite에서 검증했으며 MySQL 실행 검증을 대신하지 않는다.

## 예제 데이터

```sql
CREATE TABLE results(id INTEGER PRIMARY KEY, team TEXT, score INTEGER);
INSERT INTO results VALUES
(1,'A',10),(2,'A',20),(3,'A',20),(4,'A',30),
(5,'B',0),(6,'B',0);
```

## 쿼리와 결과

```sql
SELECT id, score, LEAD(score) OVER (PARTITION BY team ORDER BY id) AS next_score FROM results ORDER BY id;
```

결과(행 배열): `[[1,10,20],[2,20,20],[3,20,30],[4,30,null],[5,0,0],[6,0,null]]`

A팀 마지막 기록과 B팀 마지막 기록에는 다음 행이 없어 NULL이 나온다. B팀 첫 행의 다음 값은 실제 0이므로 끝을 나타내는 NULL과 구분된다.

## 다음의 기준

여기서는 id 순서를 기록 순서로 가정했다. 실제 시간 순서를 사용할 때는 시각과 동률 해소 기준을 함께 정해야 한다. 다음 행에 값이 NULL인 경우와 다음 행 자체가 없는 경우까지 구분하려면 다음 id도 함께 조회할 수 있다.

## 참고

- [SQLite 윈도 함수](https://www.sqlite.org/windowfunctions.html)
- [MySQL 윈도 함수](https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html)
