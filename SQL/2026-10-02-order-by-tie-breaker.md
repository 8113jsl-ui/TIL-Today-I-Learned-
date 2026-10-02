# ORDER BY 없이 기본 키 순서를 기대하지 않기

복습 정리일: 2026-10-02

기존 모닝테스트 파일에는 ORDER BY가 없으면 book_id 순서로 나온다는 메모가 있습니다. 관찰한 출력 순서와 보장된 순서는 구분해야 해요. 같은 값이 있을 때의 정렬 기준도 함께 연습합니다.

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
SELECT id, name, team_id
FROM people
WHERE team_id IS NOT NULL
ORDER BY team_id ASC, id DESC;
```

SQLite에서 확인한 결과입니다. 원본 MySQL 실습의 실행 결과를 뜻하지는 않습니다.

```text
2 | Bo | 1
1 | Ari | 1
3 | Cam | 2
```

team_id가 같으면 id 내림차순이 적용되어 Bo가 Ari보다 먼저 나옵니다. 결과 순서가 필요할 때는 ORDER BY를 명시하고, 동률도 일정하게 처리하려면 고유한 키를 마지막 기준으로 둡니다. 인덱스나 실행 계획이 달라져도 우연히 보던 순서를 전제로 삼지 않겠습니다.

## 참고

- 저장소의 [조인 실습](조인.sql)과 [모닝테스트](20260915_현대AI서비스_SQL_모닝테스트.sql)를 바탕으로 복습 주제를 선정했습니다.
- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
