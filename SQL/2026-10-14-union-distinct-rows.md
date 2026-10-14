# UNION이 제거하는 중복의 기준

추가 학습 정리일: 2026-10-14

두 조회 결과에서 점수 목록을 합쳐 보겠습니다. 같은 점수가 여러 번 나와도 한 번씩만 남기려는 예제예요.

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
SELECT points FROM scores WHERE team = 'A'
UNION
SELECT points FROM scores WHERE points >= 80
ORDER BY points DESC;
```

```text
90
80
70
```

첫 조회의 90점 두 개와 두 번째 조회의 90점들이 하나로 합쳐집니다. 중복 여부는 선택한 열 전체로 판단하므로 id까지 선택하면 서로 다른 id의 행은 남아요. 양쪽 SELECT의 열 개수도 같아야 합니다. 최종 정렬은 마지막 ORDER BY에서 지정합니다.

## 참고

- [기존 집계 학습](sql-group-by-having-practice.md)
- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
