# 나눗셈 전에 REAL로 변환하기

정리일: 2026-10-18

수업 필기에서 확장한 추가 학습이다. 아래 데이터는 동작 확인을 위한 자체 예제이며 SQLite 기준이다.

## 확인할 내용

정수 나눗셈 이후의 형 변환으로는 이미 버린 소수 부분을 복구할 수 없다.

## 실행 예제

각 예제는 테이블 생성 없이 독립적으로 실행할 수 있다.

```sql
SELECT 7 / 2 AS integer_result,
       CAST(7 / 2 AS REAL) AS converted_after,
       CAST(7 AS REAL) / 2 AS converted_before;
```

결과(행별 배열, null은 SQL NULL):

```json
[
  [
    3,
    3,
    3.5
  ]
]
```

## 정리

SQLite에서 두 정수의 나눗셈은 정수 결과가 된다. 실수 계산이 목적이면 연산 전에 피연산자를 변환한다. 데이터베이스마다 타입과 연산 규칙이 다르므로 다른 DB에서도 같은 결과라고 단정하지 않는다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_expr.html)
