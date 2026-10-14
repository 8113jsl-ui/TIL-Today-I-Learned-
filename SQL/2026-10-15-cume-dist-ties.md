# CUME_DIST에서 동점까지 포함한 누적 비율

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
SELECT id,score,CUME_DIST() OVER (ORDER BY score) AS cumulative_fraction FROM results WHERE team='A' ORDER BY score,id;
```

결과(행 배열): `[[1,10,0.25],[2,20,0.75],[3,20,0.75],[4,30,1]]`

A팀 네 행 중 10점 이하가 하나여서 0.25, 20점 이하가 세 개여서 두 20점 행 모두 0.75가 된다. 마지막 값에서는 1에 도달한다.

## 동점 정의를 유지하기

함수 안의 ORDER BY에 id까지 추가하면 두 20점 행이 더 이상 같은 정렬값이 아니게 된다. 점수에 대한 누적 분포를 구하려면 점수만으로 동점을 정의하고 최종 표시 순서는 바깥 ORDER BY에서 정한다.

## 참고

- [SQLite 윈도 함수](https://www.sqlite.org/windowfunctions.html)
- [MySQL 윈도 함수](https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html)
