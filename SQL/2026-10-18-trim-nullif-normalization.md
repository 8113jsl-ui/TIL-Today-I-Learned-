# TRIM과 NULLIF로 공백 입력 정리하기

정리일: 2026-10-18

수업 필기에서 확장한 추가 학습이다. 아래 데이터는 동작 확인을 위한 자체 예제이며 SQLite 기준이다.

## 확인할 내용

빈 값으로 취급할 입력 규칙을 먼저 정하고 변환한다.

## 실행 예제

각 예제는 테이블 생성 없이 독립적으로 실행할 수 있다.

```sql
WITH inputs(id, txt) AS (VALUES (1, '  SQL  '), (2, '   '), (3, ''), (4, NULL))
SELECT id, NULLIF(TRIM(txt), '') AS cleaned FROM inputs ORDER BY id;
```

결과(행별 배열, null은 SQL NULL):

```json
[
  [
    1,
    "SQL"
  ],
  [
    2,
    null
  ],
  [
    3,
    null
  ],
  [
    4,
    null
  ]
]
```

## 정리

SQLite에서 기본 TRIM은 양끝의 일반 공백을 제거한다. 모든 탭이나 줄바꿈을 자동으로 없애는 규칙으로 생각하면 안 된다. 원문 보존이 필요하면 별도 컬럼에 정리한 값을 둔다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_corefunc.html)
