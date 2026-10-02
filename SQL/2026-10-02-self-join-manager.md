# 같은 테이블을 두 역할로 읽는 셀프 조인

복습 정리일: 2026-10-02

기존 실습에 사원번호와 상사번호가 함께 등장합니다. 사람과 관리자를 한 줄에 표시하려면 같은 테이블에 서로 다른 별칭을 붙이면 됩니다.

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
SELECT employee.name AS employee, manager.name AS manager
FROM people AS employee
LEFT JOIN people AS manager ON employee.manager_id = manager.id
ORDER BY employee.id;
```

SQLite에서 확인한 결과입니다. 원본 MySQL 실습의 실행 결과를 뜻하지는 않습니다.

```text
Ari | NULL
Bo | Ari
Cam | Ari
Dan | NULL
```

employee는 조회할 사람, manager는 연결할 관리자 역할입니다. 이름이 아니라 식별자로 연결합니다. 관리자가 없는 사람도 남기려고 LEFT JOIN을 사용했어요. 같은 테이블을 서브쿼리에서 참조하는 모든 SQL을 셀프 조인이라고 부르는 것은 아닙니다.

## 참고

- 저장소의 [조인 실습](조인.sql)과 [모닝테스트](20260915_현대AI서비스_SQL_모닝테스트.sql)를 바탕으로 복습 주제를 선정했습니다.
- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
