# EXCEPT의 왼쪽과 오른쪽 구분하기

정리일: 2026-10-18

수업 필기에서 확장한 추가 학습이다. 아래 데이터는 동작 확인을 위한 자체 예제이며 SQLite 기준이다.

## 확인할 내용

신청자 중 완료 목록에 없는 번호를 찾는다.

## 실행 예제

각 예제는 테이블 생성 없이 독립적으로 실행할 수 있다.

```sql
WITH applicants(id) AS (VALUES (1), (2), (2), (3)),
completed(id) AS (VALUES (2), (4))
SELECT id FROM applicants EXCEPT SELECT id FROM completed ORDER BY id;
```

결과(행별 배열, null은 SQL NULL):

```json
[
  [
    1
  ],
  [
    3
  ]
]
```

## 정리

신청 목록에서 완료 목록을 뺀 결과다. 순서를 반대로 쓰면 4가 남는다. EXCEPT 역시 중복을 제거하므로 미완료 건수와 사람 수를 혼동하지 않는다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_select.html)
