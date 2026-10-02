# INNER JOIN으로 소속 팀 연결하기

복습 정리일: 2026-10-02

사원과 부서처럼 연결된 데이터를 조회할 때는 두 테이블을 어떤 키로 연결할지 먼저 정합니다. 기존 조인 실습을 작은 팀 목록으로 다시 구성했어요.

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
INNER JOIN teams AS t ON p.team_id = t.id
ORDER BY p.id;
```

SQLite에서 확인한 결과입니다. 원본 MySQL 실습의 실행 결과를 뜻하지는 않습니다.

```text
Ari | Data
Bo | Data
Cam | Web
```

Dan은 team_id가 NULL이어서 일치하는 팀이 없습니다. 따라서 이 결과에는 나오지 않아요. 외래 키를 선언해도 조회할 때의 조인 조건을 자동으로 작성해 주지는 않습니다. 각 테이블의 id가 뜻하는 대상을 구분해야 합니다.

## 참고

- 저장소의 [조인 실습](조인.sql)과 [모닝테스트](20260915_현대AI서비스_SQL_모닝테스트.sql)를 바탕으로 복습 주제를 선정했습니다.
- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
