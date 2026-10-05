# 도서 코드의 표시 형식과 원본 키

복습 정리일: 2026-10-05 (원래 수업일이 아님)

도서 주문 SQL 실습을 작은 가상 데이터로 재구성했다. 아래 쿼리는 **SQLite용**이며, 원본 MySQL 문법과의 차이를 구분한다.

## 실행 예제

```sql
SELECT code, SUBSTR(code,1,2)||'-'||SUBSTR(code,-3) AS display_code FROM (SELECT 'BK001' AS code UNION ALL SELECT 'BK010') ORDER BY code;
```

예상 결과(행 배열): `[["BK001","BK-001"],["BK010","BK-010"]]`

BK와 마지막 세 자리를 나누어 하이픈을 넣었다. 고정 길이 코드라는 전제에서만 원하는 형식이 된다.

## 식별자와 표시 문자열

서로 다른 긴 코드도 앞 두 글자와 끝 세 글자가 같으면 같은 표시값이 될 수 있다. 표시용 변환 결과를 검증 없이 기본 키로 사용하면 안 된다. 원본 코드를 함께 남기면 조회 결과를 다시 원래 행과 연결하기 쉽다.

## 참고

- [원본 도서 실습](day2%20실습문제.sql)
- [SQLite 참고 문서](https://www.sqlite.org/lang_corefunc.html)
