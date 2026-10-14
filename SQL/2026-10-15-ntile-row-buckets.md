# NTILE은 같은 값도 다른 구간에 나눌 수 있다

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
SELECT id,score,NTILE(3) OVER (ORDER BY score,id) AS bucket FROM results ORDER BY score,id;
```

결과(행 배열): `[[5,0,1],[6,0,1],[1,10,2],[2,20,2],[3,20,3],[4,30,3]]`

여섯 행을 세 구간으로 나누어 각 구간에 두 행이 들어간다. 20점 두 행은 서로 다른 구간으로 갈라진다.

## 행 수 구간과 점수 구간

NTILE 결과를 같은 점수끼리 묶인 등급으로 해석하면 안 된다. 예제는 id로 동점 행의 순서를 확정했다. 업무에서 같은 점수는 반드시 같은 등급이어야 한다면 점수 경계나 DENSE_RANK 등 다른 기준을 검토해야 한다.

## 참고

- [SQLite 윈도 함수](https://www.sqlite.org/windowfunctions.html)
- [MySQL 윈도 함수](https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html)
