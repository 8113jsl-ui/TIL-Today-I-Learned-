# UNION ALL로 중복 발생 횟수 보존하기

추가 학습 정리일: 2026-10-14

조회 경로가 겹친 기록도 그대로 남겨야 한다면 UNION ALL을 사용합니다. 앞의 UNION 예제와 같은 조건으로 비교해 볼게요.

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
UNION ALL
SELECT points FROM scores WHERE points >= 80
ORDER BY points DESC;
```

```text
90
90
90
90
80
70
```

첫 조회는 세 행, 두 번째 조회도 세 행이어서 총 여섯 행입니다. 같은 원본 행이 양쪽 조건을 만족하면 두 번 포함돼요. 실제 사람 수나 주문 수를 계산하려는 경우 중복 집계가 아닌지 확인해야 합니다. UNION ALL은 중복 제거를 하지 않는다는 의미이지 두 입력의 출력 순서를 보장한다는 뜻은 아닙니다.

## 참고

- [기존 집계 학습](sql-group-by-having-practice.md)
- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
