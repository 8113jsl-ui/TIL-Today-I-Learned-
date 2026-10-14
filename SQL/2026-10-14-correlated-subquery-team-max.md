# 팀별 최고 점수와 같은 행 모두 찾기

추가 학습 정리일: 2026-10-14

전체 최고점 대신 각 행이 속한 팀의 최고점과 비교합니다. 동점이 있을 때도 모두 남기는 조건이에요.

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
SELECT s.id, s.team, s.points FROM scores AS s
WHERE s.points = (
  SELECT MAX(other.points) FROM scores AS other
  WHERE other.team = s.team
)
ORDER BY s.id;
```

```text
1 | A | 90
2 | A | 90
4 | B | 80
```

안쪽의 s.team은 바깥 행을 참조합니다. A에서는 두 행이 90점으로 함께 남고 B에서는 80점이 남아요. 개념적으로 팀마다 비교한다고 읽되 실제 실행 횟수는 실행 계획을 확인해야 합니다. 이 예제는 team과 points에 NOT NULL을 지정해 NULL 비교 문제를 별도로 만들지 않았습니다.

## 참고

- [기존 집계 학습](sql-group-by-having-practice.md)
- [SQLite 공식 문서](https://www.sqlite.org/lang_expr.html)
