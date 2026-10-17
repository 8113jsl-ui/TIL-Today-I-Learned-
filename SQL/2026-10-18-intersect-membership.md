# INTERSECT로 두 목록의 공통 값 찾기

정리일: 2026-10-18

수업 필기에서 확장한 추가 학습이다. 아래 데이터는 동작 확인을 위한 자체 예제이며 SQLite 기준이다.

## 확인할 내용

양쪽에 모두 등장한 번호만 중복 없이 남기는 예제다.

## 실행 예제

각 예제는 테이블 생성 없이 독립적으로 실행할 수 있다.

```sql
WITH a(id) AS (VALUES (1), (2), (2), (3)),
b(id) AS (VALUES (2), (3), (4))
SELECT id FROM a INTERSECT SELECT id FROM b ORDER BY id;
```

결과(행별 배열, null은 SQL NULL):

```json
[
  [
    2
  ],
  [
    3
  ]
]
```

## 정리

a에 2가 두 번 있어도 결과에는 한 번 나온다. 횟수 비교가 필요한 문제에는 이 결과만으로 충분하지 않다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
