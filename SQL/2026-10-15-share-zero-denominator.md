# 전체 대비 비중에서 0인 분모 처리하기

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
SELECT id,ROUND(100.0*score/NULLIF(SUM(score) OVER (PARTITION BY team),0),2) AS percent_share FROM results ORDER BY id;
```

결과(행 배열): `[[1,12.5],[2,25],[3,25],[4,37.5],[5,null],[6,null]]`

A팀 합계 80을 분모로 각 행의 비율을 계산한다. B팀은 합계가 0이므로 NULLIF로 분모를 NULL로 바꿔 비율을 정의할 수 없음을 표시한다.

## 0퍼센트와 계산 불가

계산 불가를 무조건 0으로 채우면 실제 비중이 0인 행과 구별되지 않는다. 여기서는 점수가 음수가 아닌 자료를 가정한다. 취소·환불처럼 음수가 섞이는 지표라면 비중의 해석과 분모 정의를 다시 검토해야 한다.

## 참고

- [SQLite 윈도 함수](https://www.sqlite.org/windowfunctions.html)
- [MySQL 윈도 함수](https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html)
