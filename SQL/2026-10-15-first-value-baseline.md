# FIRST_VALUE로 시작점 대비 변화 보기

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
SELECT id, score-FIRST_VALUE(score) OVER (PARTITION BY team ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS change_from_start FROM results ORDER BY id;
```

결과(행 배열): `[[1,0],[2,10],[3,10],[4,20],[5,0],[6,0]]`

A팀은 첫 점수 10을 기준으로 0·10·10·20만큼 차이가 난다. B팀은 기준값도 현재값도 0이다.

## 첫 값과 최솟값

기록 순서에서 첫 값은 최솟값이라는 뜻이 아니다. 예제의 점수를 역순으로 입력하면 시작점은 달라진다. 기준점을 처음 관측한 값으로 잡을지 최소값으로 잡을지에 따라 함수와 정렬 조건이 달라진다.

## 참고

- [SQLite 윈도 함수](https://www.sqlite.org/windowfunctions.html)
- [MySQL 윈도 함수](https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html)
