# BETWEEN은 양쪽 경계를 포함한다

정리일: 2026-10-18

수업 필기에서 확장한 추가 학습이다. 아래 데이터는 동작 확인을 위한 자체 예제이며 SQLite 기준이다.

## 확인할 내용

점수 범위의 시작과 끝을 직접 넣어 포함 여부를 확인한다.

## 실행 예제

각 예제는 테이블 생성 없이 독립적으로 실행할 수 있다.

```sql
WITH scores(score) AS (VALUES (59), (60), (80), (81))
SELECT score, score BETWEEN 60 AND 80 AS included FROM scores ORDER BY score;
```

결과(행별 배열, null은 SQL NULL):

```json
[
  [
    59,
    0
  ],
  [
    60,
    1
  ],
  [
    80,
    1
  ],
  [
    81,
    0
  ]
]
```

## 정리

60과 80 모두 포함된다. 시간 구간을 연속해서 나눌 때는 끝점이 겹치지 않도록 >= 시작 AND < 다음시작 같은 조건도 고려한다. 숫자로 확인한 예제다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_expr.html)
