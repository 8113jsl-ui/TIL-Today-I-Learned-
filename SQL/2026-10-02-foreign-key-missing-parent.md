# 외래 키를 추가하기 전에 기존 데이터 확인하기

복습 정리일: 2026-10-02

기존 조인 실습에는 참조할 부서가 없는 사원 때문에 외래 키 추가가 실패한 기록이 있습니다. 아래는 동작을 확인하기 위해 별도로 만든 SQLite 예제입니다.

## 실행해 보기

```sql
PRAGMA foreign_keys = ON;
CREATE TABLE parent_team (id INTEGER PRIMARY KEY);
CREATE TABLE child_person (
  id INTEGER PRIMARY KEY,
  team_id INTEGER REFERENCES parent_team(id)
);
INSERT INTO parent_team VALUES (1);
INSERT INTO child_person VALUES (1, 1), (2, NULL);
SELECT id, team_id FROM child_person ORDER BY id;
```

SQLite에서 확인한 결과입니다. 원본 MySQL 실습의 실행 결과를 뜻하지는 않습니다.

```text
1 | 1
2 | NULL
```

존재하는 팀 1과 NULL은 허용되지만 팀 99를 넣으면 무결성 오류가 발생합니다. NULL을 허용하지 않으려면 NOT NULL도 필요해요. 실제 데이터의 잘못된 참조는 원인을 확인한 뒤 수정해야 합니다. 오류를 없애기 위해 무조건 NULL로 덮어쓰지는 않겠습니다. SQLite에서는 연결별 외래 키 설정을 확인하며, 기존 MySQL 실습의 ALTER TABLE 문법을 그대로 적용하지 않습니다.

## 참고

- 저장소의 [조인 실습](조인.sql)과 [모닝테스트](20260915_현대AI서비스_SQL_모닝테스트.sql)를 바탕으로 복습 주제를 선정했습니다.
- [SQLite 공식 문서](https://www.sqlite.org/foreignkeys.html)
