# 상세 행을 유지하면서 팀 합계 붙이기

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
SELECT id,team,score,SUM(score) OVER (PARTITION BY team) AS team_total FROM results ORDER BY id;
```

결과(행 배열): `[[1,"A",10,80],[2,"A",20,80],[3,"A",20,80],[4,"A",30,80],[5,"B",0,0],[6,"B",0,0]]`

A팀 합계 80이 네 상세 행에 반복된다. GROUP BY로 팀당 한 행을 만드는 결과와 달리 원래 여섯 행을 유지한다.

## 반복 합계를 다시 더하지 않기

이 결과의 team_total을 다시 합산하면 A팀 합계가 네 번 더해진다. 상세표에 붙인 집계값은 중복 표시일 수 있으므로 후속 보고서의 집계 단위를 확인해야 한다. 총계가 필요하면 원본 score를 합하거나 팀별 한 행을 사용한다.

## 참고

- [SQLite 윈도 함수](https://www.sqlite.org/windowfunctions.html)
- [MySQL 윈도 함수](https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html)
