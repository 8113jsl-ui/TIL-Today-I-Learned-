# LAG로 직전 기록과 점수 차이 계산하기

추가 학습 정리일: 2026-10-14

현재 기록에서 같은 팀의 직전 기록을 빼보겠습니다. 다음 예제의 이전이라는 말은 id 순서를 기준으로 합니다.

기존 SQL 집계 학습을 확장한 자체 예제입니다. 수업에서 직접 다뤘다는 의미는 아니며, 아래 결과는 SQLite에서 검증합니다.

## 예제 준비

새 데이터베이스에서 실행하세요. 모든 글은 독립적으로 실행할 수 있도록 같은 작은 데이터를 사용합니다.

```sql
CREATE TABLE scores (
  id INTEGER PRIMARY KEY, team TEXT NOT NULL, points INTEGER NOT NULL
);
INSERT INTO scores VALUES
  (1, 'A', 90), (2, 'A', 90), (3, 'A', 70),
  (4, 'B', 80), (5, 'B', 60);
```

## 조회와 결과

```sql
SELECT id, team, points,
  LAG(points) OVER (PARTITION BY team ORDER BY id) AS previous_points,
  points - LAG(points) OVER (PARTITION BY team ORDER BY id) AS difference
FROM scores ORDER BY team, id;
```

```text
1 | A | 90 | NULL | NULL
2 | A | 90 | 90 | 0
3 | A | 70 | 90 | -20
4 | B | 80 | NULL | NULL
5 | B | 60 | 80 | -20
```

각 팀의 첫 행에는 직전 기록이 없어 이전 값과 차이가 NULL입니다. 이를 0으로 바꾸면 기록이 없다는 상태와 실제 0점이 같아질 수 있어요. 날짜에 빈 구간이 있다면 LAG는 달력상 전날이 아니라 정렬된 이전 행을 가리킨다는 점도 확인해야 합니다.

## 참고

- [기존 집계 학습](sql-group-by-having-practice.md)
- [SQLite 공식 문서](https://www.sqlite.org/windowfunctions.html)
