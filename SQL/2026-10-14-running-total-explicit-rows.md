# 행 순서와 범위를 지정해 누적합 구하기

추가 학습 정리일: 2026-10-14

집계로 행을 줄이지 않고 각 기록 옆에 누적 점수를 붙입니다. 여기서는 id를 기록 순서로 삼는다고 명시합니다.

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
  SUM(points) OVER (
    PARTITION BY team ORDER BY id
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_points
FROM scores ORDER BY team, id;
```

```text
1 | A | 90 | 90
2 | A | 90 | 180
3 | A | 70 | 250
4 | B | 80 | 80
5 | B | 60 | 140
```

A는 90, 180, 250으로 증가하고 B는 80부터 별도로 시작합니다. ROWS 범위를 명시해 처음부터 현재 행까지 더합니다. 실제 시계열에서는 id가 시간 순서라는 보장이 없다면 날짜와 고유 키 등 적절한 기준을 써야 합니다. 금액이 음수인 데이터라면 누적합이 항상 증가하는 것도 아닙니다.

## 참고

- [기존 집계 학습](sql-group-by-having-practice.md)
- [SQLite 공식 문서](https://www.sqlite.org/windowfunctions.html)
