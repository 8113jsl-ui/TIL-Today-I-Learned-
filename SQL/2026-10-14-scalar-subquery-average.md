# 전체 평균보다 높은 행을 서브쿼리로 찾기

추가 학습 정리일: 2026-10-14

집계 결과와 개별 행을 비교하려면 평균을 먼저 구한 뒤 비교 기준으로 사용할 수 있어요.

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
SELECT id, points FROM scores
WHERE points > (SELECT AVG(points) FROM scores)
ORDER BY id;
```

```text
1 | 90
2 | 90
4 | 80
```

다섯 점수의 합은 390이고 평균은 78입니다. 따라서 80점도 결과에 포함됩니다. 이 서브쿼리는 GROUP BY가 없는 AVG 집계여서 하나의 값을 반환해요. 여러 행을 반환할 수 있는 일반 조회를 그대로 스칼라 값처럼 사용하지 않도록 주의합니다. 빈 입력의 AVG는 NULL이므로 비교 조건은 참이 되지 않습니다.

## 참고

- [기존 집계 학습](sql-group-by-having-practice.md)
- [SQLite 공식 문서](https://www.sqlite.org/lang_expr.html)
