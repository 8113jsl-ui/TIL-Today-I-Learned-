# NOT IN에 NULL이 섞이면 생기는 일

복습 정리일: 2026-10-02

소속 인원이 없는 팀을 찾으려고 NOT IN을 사용하면 예상과 다른 결과를 볼 수 있습니다. people.team_id에는 미배정 인원의 NULL이 들어 있어요.

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
WHERE NOT EXISTS (
  SELECT 1 FROM people AS p WHERE p.team_id = t.id
)
ORDER BY t.id;
```

SQLite에서 확인한 결과입니다. 원본 MySQL 실습의 실행 결과를 뜻하지는 않습니다.

```text
Design
```

이 데이터에서 t.id NOT IN (SELECT team_id FROM people)은 아무 행도 반환하지 않습니다. Design의 id도 NULL과의 비교 때문에 참으로 판정되지 않아요. NOT EXISTS는 일치하는 사람이 없는지를 직접 표현합니다. NOT IN을 쓴다면 서브쿼리의 NULL을 제외하고 바깥 키의 NULL 가능성도 따져야 합니다.

## 참고

- 저장소의 [조인 실습](조인.sql)과 [모닝테스트](20260915_현대AI서비스_SQL_모닝테스트.sql)를 바탕으로 복습 주제를 선정했습니다.
- [SQLite 공식 문서](https://www.sqlite.org/lang_expr.html)
