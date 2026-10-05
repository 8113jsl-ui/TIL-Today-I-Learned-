# 월을 분기로 바꾸는 경계 확인

복습 정리일: 2026-10-05 (원래 수업일이 아님)

도서 주문 SQL 실습을 작은 가상 데이터로 재구성했다. 아래 쿼리는 **SQLite용**이며, 원본 MySQL 문법과의 차이를 구분한다.

## 실행 예제

```sql
SELECT month, CAST((month-1)/3 AS INTEGER)+1 AS quarter FROM (SELECT 1 AS month UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 12) ORDER BY month;
```

예상 결과(행 배열): `[[1,1],[3,1],[4,2],[12,4]]`

1~3월은 1분기, 4월은 2분기, 12월은 4분기다. 원본의 QUARTER 함수와 같은 분류 기준을 유효한 정수 월에 대한 산술식으로 복습했다.

## 유효 범위와 회계연도

이 식은 월이 1~12인 경우만 다룬다. 0이나 13도 계산 자체는 될 수 있으므로 입력 범위를 검증해야 한다. 또한 1월에 시작하는 일반 분기 기준이며 회사의 회계연도가 다르면 별도 규칙이 필요하다.

## 참고

- [원본 도서 실습](day2%20실습문제.sql)
- [SQLite 참고 문서](https://www.sqlite.org/lang_expr.html)
