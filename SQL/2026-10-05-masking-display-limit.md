# 이름 마스킹과 원본 데이터 보호 구분

복습 정리일: 2026-10-05 (원래 수업일이 아님)

도서 주문 SQL 실습을 작은 가상 데이터로 재구성했다. 아래 쿼리는 **SQLite용**이며, 원본 MySQL 문법과의 차이를 구분한다.

## 실행 예제

```sql
SELECT name, CASE WHEN name IS NULL THEN '(missing)' WHEN LENGTH(name)=0 THEN '(empty)' ELSE SUBSTR(name,1,1)||'**' END AS masked FROM (SELECT 'Alice' AS name UNION ALL SELECT '' UNION ALL SELECT NULL) ORDER BY masked;
```

예상 결과(행 배열): `[["","(empty)"],[null,"(missing)"],["Alice","A**"]]`

실제 인물이 아닌 가상 이름을 사용했다. 원본의 길이별 마스킹 대신 고정된 별 두 개를 붙여 표시 규칙을 단순화했다. 빈 문자열과 미입력도 구분했다.

## 표시가 전부는 아니다

마스킹된 열을 만들었다고 원본 데이터가 암호화되거나 삭제되는 것은 아니다. 예제는 차이를 보기 위해 원본 이름도 함께 조회하지만 실제 공개 화면에 원본 열을 전달하면 마스킹 목적을 달성할 수 없다.

## 참고

- [원본 도서 실습](day2%20실습문제.sql)
- [SQLite 참고 문서](https://www.sqlite.org/lang_corefunc.html)
