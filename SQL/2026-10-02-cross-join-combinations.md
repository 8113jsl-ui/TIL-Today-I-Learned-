# CROSS JOIN의 행 수를 먼저 계산하기

복습 정리일: 2026-10-02

기존 실습의 CROSS JOIN을 보고, 연결 조건 없이 두 목록을 결합하면 무엇이 나오는지 확인해 봅니다. 여기서는 두 사람과 두 팀의 가능한 조합을 만듭니다.

## 예제 데이터

새 SQLite 데이터베이스에서 먼저 실행합니다. 이름과 데이터는 자체 구성한 예제입니다.

```sql
CREATE TABLE teams (id INTEGER PRIMARY KEY, name TEXT);
CREATE TABLE people (
  id INTEGER PRIMARY KEY, name TEXT,
  team_id INTEGER, manager_id INTEGER
);
INSERT INTO teams VALUES (1, 'Data'), (2, 'Web'), (3, 'Design');
INSERT INTO people VALUES
  (1, 'Ari', 1, NULL), (2, 'Bo', 1, 1),
  (3, 'Cam', 2, 1), (4, 'Dan', NULL, NULL);
```

## 실행해 보기

```sql
SELECT p.name, t.name
FROM people AS p CROSS JOIN teams AS t
WHERE p.id <= 2 AND t.id <= 2
ORDER BY p.id, t.id;
```

SQLite에서 확인한 결과입니다. 원본 MySQL 실습의 실행 결과를 뜻하지는 않습니다.

```text
Ari | Data
Ari | Web
Bo | Data
Bo | Web
```

결과는 2 × 2로 네 행입니다. 이 목록은 실제 소속 관계를 나타내지 않아요. 가능한 조합이 목적이면 유용하지만 소속을 조회하려던 것이라면 연결 조건을 빠뜨린 셈입니다. 필터가 없는 전체 예제에서는 4 × 3으로 열두 행이 됩니다.

## 참고

- 저장소의 [조인 실습](조인.sql)과 [모닝테스트](20260915_현대AI서비스_SQL_모닝테스트.sql)를 바탕으로 복습 주제를 선정했습니다.
- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
