# 집계한 결과를 FROM에서 다시 조회하기

추가 학습 정리일: 2026-10-14

팀별 합계를 한 번 만든 뒤 그 결과에 조건을 적용해 봅니다. 중간 결과가 어떤 행으로 구성되는지 나누어 읽는 연습입니다.

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
SELECT team, total_points
FROM (
  SELECT team, SUM(points) AS total_points
  FROM scores GROUP BY team
) AS totals
WHERE total_points >= 200
ORDER BY team;
```

```text
A | 250
```

안쪽 결과는 A 250점과 B 140점입니다. 바깥 WHERE는 원본 점수가 아닌 팀 합계를 검사해요. 이처럼 FROM 안의 서브쿼리를 파생 테이블이라고 부릅니다. 이 조건만 있다면 HAVING으로도 표현할 수 있지만, 중간 집계 결과에 다른 처리를 이어 붙일 때 단계가 잘 드러납니다.

## 참고

- [기존 집계 학습](sql-group-by-having-practice.md)
- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
