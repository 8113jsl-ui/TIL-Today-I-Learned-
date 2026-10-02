# 인원이 없는 팀까지 세기

복습 정리일: 2026-10-02

팀별 인원을 집계할 때 Design처럼 아무도 없는 팀도 0으로 표시하고 싶습니다. 팀 목록을 왼쪽에 두고, 실제 연결된 사람의 키를 세어 봅니다.

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
SELECT t.name, COUNT(p.id) AS members, COUNT(*) AS joined_rows
FROM teams AS t
LEFT JOIN people AS p ON p.team_id = t.id
GROUP BY t.id, t.name
ORDER BY t.id;
```

SQLite에서 확인한 결과입니다. 원본 MySQL 실습의 실행 결과를 뜻하지는 않습니다.

```text
Data | 2 | 2
Web | 1 | 1
Design | 0 | 1
```

Design은 LEFT JOIN이 남긴 행이 하나여서 COUNT(*)는 1입니다. 하지만 그 행의 p.id는 NULL이라 COUNT(p.id)는 0이에요. 팀 수, 사람 수, 조인 결과 행 수 중 무엇을 세려는지 구분하면 집계 기준을 정하기 쉽습니다.

## 참고

- 저장소의 [조인 실습](조인.sql)과 [모닝테스트](20260915_현대AI서비스_SQL_모닝테스트.sql)를 바탕으로 복습 주제를 선정했습니다.
- [SQLite 공식 문서](https://www.sqlite.org/lang_aggfunc.html)
