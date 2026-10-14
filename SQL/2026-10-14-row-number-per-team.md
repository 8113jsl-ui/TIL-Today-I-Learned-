# ROW_NUMBER로 팀마다 순번 붙이기

추가 학습 정리일: 2026-10-14

팀 안에서 점수가 높은 순으로 번호를 붙입니다. 동점에서는 id가 작은 행을 먼저 놓겠다는 기준을 예제에서 정했어요.

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
  ROW_NUMBER() OVER (
    PARTITION BY team ORDER BY points DESC, id ASC
  ) AS position
FROM scores ORDER BY team, position;
```

```text
1 | A | 90 | 1
2 | A | 90 | 2
3 | A | 70 | 3
4 | B | 80 | 1
5 | B | 60 | 2
```

A의 두 90점 행에도 서로 다른 번호가 붙습니다. B에서는 번호가 다시 1부터 시작해요. 팀마다 정확히 한 행을 뽑으려면 이 결과를 서브쿼리로 감싸 position = 1을 검사할 수 있습니다. 동점을 모두 선택하는 요구와 구분해야 합니다.

## 참고

- [기존 집계 학습](sql-group-by-having-practice.md)
- [SQLite 공식 문서](https://www.sqlite.org/windowfunctions.html)
