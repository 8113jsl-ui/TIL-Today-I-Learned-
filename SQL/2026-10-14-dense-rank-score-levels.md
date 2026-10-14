# DENSE_RANK로 점수 구간에 연속 순위 붙이기

추가 학습 정리일: 2026-10-14

점수가 서로 다른 순서대로 순위를 주고 싶을 때 DENSE_RANK를 사용할 수 있습니다. RANK와 동일한 데이터로 확인해 봅니다.

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
SELECT id, points,
  DENSE_RANK() OVER (ORDER BY points DESC) AS ranking
FROM scores ORDER BY points DESC, id;
```

```text
1 | 90 | 1
2 | 90 | 1
4 | 80 | 2
3 | 70 | 3
5 | 60 | 4
```

90점 다음 80점은 2위로 이어집니다. 상위 두 순위를 선택하면 90점 두 행과 80점 한 행, 총 세 행이 나와요. 정확히 두 행이 필요한지, 상위 두 점수 구간이 필요한지에 따라 순위 함수를 선택해야 합니다.

## 참고

- [기존 집계 학습](sql-group-by-having-practice.md)
- [SQLite 공식 문서](https://www.sqlite.org/windowfunctions.html)
