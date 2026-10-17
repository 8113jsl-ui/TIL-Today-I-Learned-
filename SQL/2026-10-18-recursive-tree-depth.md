# 재귀 CTE로 트리의 깊이 계산하기

정리일: 2026-10-18

수업 필기에서 확장한 추가 학습이다. 아래 데이터는 동작 확인을 위한 자체 예제이며 SQLite 기준이다.

## 확인할 내용

부모 번호가 있는 자료에서 루트부터 자식으로 내려가며 깊이를 붙인다.

## 실행 예제

각 예제는 테이블 생성 없이 독립적으로 실행할 수 있다.

```sql
WITH RECURSIVE nodes(id, parent_id) AS (
  VALUES (1, NULL), (2, 1), (3, 2), (4, 1)
), walk(id, depth) AS (
  SELECT id, 0 FROM nodes WHERE parent_id IS NULL
  UNION ALL
  SELECT n.id, w.depth + 1
  FROM nodes n JOIN walk w ON n.parent_id = w.id
  WHERE w.depth < 10
)
SELECT id, depth FROM walk ORDER BY id;
```

결과(행별 배열, null은 SQL NULL):

```json
[
  [
    1,
    0
  ],
  [
    2,
    1
  ],
  [
    3,
    2
  ],
  [
    4,
    1
  ]
]
```

## 정리

이 예제는 순환이 없는 트리다. 깊이 제한은 결과를 잘라내는 안전장치이며 순환 검증을 대신하지 않는다. 루트에 연결되지 않은 노드는 조회되지 않는다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_with.html)
