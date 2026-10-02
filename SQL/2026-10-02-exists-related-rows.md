# EXISTS로 소속 인원이 있는 팀 찾기

복습 정리일: 2026-10-02

연결된 사람이 있는지만 필요하다면 사람 이름을 전부 붙일 필요는 없습니다. EXISTS로 팀마다 관련 행의 존재 여부를 확인해 봅니다.

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
SELECT t.name
FROM teams AS t
WHERE EXISTS (
  SELECT 1 FROM people AS p WHERE p.team_id = t.id
)
ORDER BY t.id;
```

SQLite에서 확인한 결과입니다. 원본 MySQL 실습의 실행 결과를 뜻하지는 않습니다.

```text
Data
Web
```

Data에 사람이 두 명이어도 바깥의 팀 행은 한 번만 선택됩니다. SELECT 1의 숫자 자체가 검사 대상은 아니며 서브쿼리가 행을 반환하는지가 중요해요. 항상 JOIN보다 빠르다고 단정하기보다는 원하는 결과와 실행 계획을 기준으로 선택합니다.

## 참고

- 저장소의 [조인 실습](조인.sql)과 [모닝테스트](20260915_현대AI서비스_SQL_모닝테스트.sql)를 바탕으로 복습 주제를 선정했습니다.
- [SQLite 공식 문서](https://www.sqlite.org/lang_expr.html)
