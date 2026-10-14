# LAST_VALUE에는 마지막까지의 프레임이 필요하다

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
SELECT id, LAST_VALUE(score) OVER (PARTITION BY team ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS frame_last, LAST_VALUE(score) OVER (PARTITION BY team ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS team_last FROM results ORDER BY id;
```

결과(행 배열): `[[1,10,30],[2,20,30],[3,20,30],[4,30,30],[5,0,0],[6,0,0]]`

현재 행까지의 범위에서는 현재 점수가 마지막 값이다. 팀의 마지막 기록을 모든 행에 붙이려면 뒤쪽 끝을 UNBOUNDED FOLLOWING으로 지정한다.

## 함수 이름만 보고 판단하지 않기

LAST_VALUE의 마지막은 조회 테이블 전체가 아니라 지정한 프레임의 마지막이다. 두 결과 열을 나란히 보면 프레임이 계산 결과를 어떻게 바꾸는지 확인할 수 있다.

## 참고

- [SQLite 윈도 함수](https://www.sqlite.org/windowfunctions.html)
- [MySQL 윈도 함수](https://dev.mysql.com/doc/refman/8.4/en/window-function-descriptions.html)
