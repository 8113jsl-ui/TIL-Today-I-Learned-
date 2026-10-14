# 최근 세 행의 이동평균과 관측 수

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
SELECT id, ROUND(AVG(score) OVER w,2) AS moving_avg, COUNT(*) OVER w AS observations FROM results WINDOW w AS (PARTITION BY team ORDER BY id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) ORDER BY id;
```

결과(행 배열): `[[1,10,1],[2,15,2],[3,16.67,3],[4,23.33,3],[5,0,1],[6,0,2]]`

시작 부분에는 앞선 행이 부족하므로 관측 수가 1개, 2개로 증가한다. 4번 행은 20·20·30의 평균이며 처음의 10은 범위에서 빠진다.

## 세 행과 사흘

이 예제는 날짜 간격을 보지 않는다. 기록이 없는 날이 있거나 하루에 여러 행이 있으면 최근 세 행과 최근 사흘은 다른 범위다. 이동평균을 보고할 때 관측 단위와 초기 구간 처리 방법을 함께 적어야 한다.

## 참고

- [SQLite 윈도 함수](https://www.sqlite.org/windowfunctions.html)
- [MySQL 윈도 함수](https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html)
