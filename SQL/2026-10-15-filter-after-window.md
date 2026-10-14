# 순번을 계산한 뒤 바깥 쿼리에서 필터링하기

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
WITH ranked AS (SELECT id,team,score,ROW_NUMBER() OVER (PARTITION BY team ORDER BY score DESC,id) AS rn FROM results) SELECT id,team,score FROM ranked WHERE rn<=2 ORDER BY team,rn;
```

결과(행 배열): `[[4,"A",30],[2,"A",20],[5,"B",0],[6,"B",0]]`

먼저 팀 안에서 점수 내림차순으로 순번을 만들고 바깥 조회에서 두 행만 남긴다. A팀 공동 20점 중에서는 id가 작은 2번이 선택된다.

## 상위 두 행과 공동 두 순위

정확히 두 행을 선택하는 기준과 공동 순위를 모두 포함하는 기준은 다르다. 공동 순위를 보존하려면 RANK나 DENSE_RANK의 정의를 검토해야 한다. 또한 순번을 만들기 전에 WHERE로 원본을 거르면 순위의 모집단 자체가 달라진다.

## 참고

- [SQLite 윈도 함수](https://www.sqlite.org/windowfunctions.html)
- [MySQL 윈도 함수](https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html)
