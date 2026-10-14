# PERCENT_RANK와 누적 비율은 다르다

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
SELECT id,ROUND(PERCENT_RANK() OVER (PARTITION BY team ORDER BY score),4) AS relative_rank FROM results ORDER BY id;
```

결과(행 배열): `[[1,0],[2,0.3333],[3,0.3333],[4,1],[5,0],[6,0]]`

A팀 20점 행은 공동 2위여서 (2-1)/(4-1)=1/3이다. CUME_DIST에서 같은 값이 0.75였던 것과 다르다. B팀은 두 행이 공동 첫 순위이므로 모두 0이다.

## 무조건 마지막이 1은 아니다

PERCENT_RANK는 (순위-1)/(행 수-1)로 이해할 수 있으며 단일 행 파티션은 0이다. 마지막 값에 동점이 있으면 최종 상대 순위가 1보다 작을 수 있다. 이를 누적 관측 비율이라고 부르지 않도록 주의한다.

## 참고

- [SQLite 윈도 함수](https://www.sqlite.org/windowfunctions.html)
- [MySQL 윈도 함수](https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html)
