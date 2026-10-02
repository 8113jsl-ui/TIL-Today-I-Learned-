# LEFT JOIN의 조건을 ON과 WHERE에 둘 때

복습 정리일: 2026-10-02

Data 팀 연결 정보만 표시하되 모든 사람을 남기려면 조건을 어디에 둘까요? 연결 조건과 최종 결과를 거르는 조건을 구분해 봅니다.

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
FROM people AS p
LEFT JOIN teams AS t
  ON p.team_id = t.id AND t.name = 'Data'
ORDER BY p.id;
```

SQLite에서 확인한 결과입니다. 원본 MySQL 실습의 실행 결과를 뜻하지는 않습니다.

```text
Ari | Data
Bo | Data
Cam | NULL
Dan | NULL
```

ON의 조건은 어떤 팀과 연결할지를 정합니다. 따라서 Cam과 Dan은 팀 이름이 NULL인 채 남아요. 같은 조건을 WHERE t.name = 'Data'로 옮기면 Ari와 Bo만 남습니다. 오른쪽 값에 대한 WHERE 조건이 미연결 행까지 제거하는지 확인해야 해요.

## 참고

- 저장소의 [조인 실습](조인.sql)과 [모닝테스트](20260915_현대AI서비스_SQL_모닝테스트.sql)를 바탕으로 복습 주제를 선정했습니다.
- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
