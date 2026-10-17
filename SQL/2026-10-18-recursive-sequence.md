# 재귀 CTE에 시작값과 종료 조건 넣기

정리일: 2026-10-18

수업 필기에서 확장한 추가 학습이다. 아래 데이터는 동작 확인을 위한 자체 예제이며 SQLite 기준이다.

## 확인할 내용

작은 정수 목록을 만들어 재귀 쿼리의 시작과 반복을 확인한다.

## 실행 예제

각 예제는 테이블 생성 없이 독립적으로 실행할 수 있다.

```sql
WITH RECURSIVE seq(n) AS (
  SELECT 2
  UNION ALL
  SELECT n + 2 FROM seq WHERE n < 8
)
SELECT n FROM seq ORDER BY n;
```

결과(행별 배열, null은 SQL NULL):

```json
[
  [
    2
  ],
  [
    4
  ],
  [
    6
  ],
  [
    8
  ]
]
```

## 정리

현재 값이 6일 때 다음 값 8이 생성된다. 현재 값 8에서는 반복하지 않는다. 증가 폭이나 상한을 바꾸면 마지막 값이 달라지므로 경계를 다시 확인한다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_with.html)
