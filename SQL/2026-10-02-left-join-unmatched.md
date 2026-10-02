# LEFT JOIN으로 미배정 인원도 남기기

복습 정리일: 2026-10-02

팀이 아직 정해지지 않은 사람까지 보고 싶다면 조회의 기준을 사람 목록으로 잡습니다. 같은 데이터에서 INNER JOIN과 결과가 어떻게 달라지는지 확인해 봅니다.

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
SELECT p.name AS person, t.name AS team
FROM people AS p
LEFT JOIN teams AS t ON p.team_id = t.id
ORDER BY p.id;
```

SQLite에서 확인한 결과입니다. 원본 MySQL 실습의 실행 결과를 뜻하지는 않습니다.

```text
Ari | Data
Bo | Data
Cam | Web
Dan | NULL
```

Dan도 한 행으로 남고 팀 이름은 NULL입니다. 왼쪽 행을 보존한다는 의미이지, 오른쪽에서 여러 행이 일치해도 한 행만 나온다는 뜻은 아니에요. 이 예제에서는 teams.id가 기본 키여서 사람당 최대 한 팀만 연결됩니다.

## 참고

- 저장소의 [조인 실습](조인.sql)과 [모닝테스트](20260915_현대AI서비스_SQL_모닝테스트.sql)를 바탕으로 복습 주제를 선정했습니다.
- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
