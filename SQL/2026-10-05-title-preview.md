# 긴 제목에만 말줄임표 붙이기

복습 정리일: 2026-10-05 (원래 수업일이 아님)

도서 주문 SQL 실습을 작은 가상 데이터로 재구성했다. 아래 쿼리는 **SQLite용**이며, 원본 MySQL 문법과의 차이를 구분한다.

## 실행 예제

```sql
SELECT title, CASE WHEN LENGTH(title)>6 THEN SUBSTR(title,1,6)||'..' ELSE title END AS preview FROM (SELECT 'SQL' AS title UNION ALL SELECT 'Database') ORDER BY title;
```

예상 결과(행 배열): `[["Database","Databa.."],["SQL","SQL"]]`

원본은 제목 길이와 관계없이 말줄임표를 붙인다. 짧은 제목은 그대로 보여 주고 실제로 잘린 제목만 표시하도록 조건을 추가했다.

## 표시 목적 확인

미리보기는 원본 제목을 바꾸는 작업이 아니다. SELECT 결과에 계산한 열을 추가할 뿐이며, 원본을 수정하려면 별도 쓰기 작업이 필요하다. 한글·이모지 등의 화면 너비는 단순 문자 수와 다를 수 있어 UI에서도 확인해야 한다.

## 참고

- [원본 도서 실습](day2%20실습문제.sql)
- [SQLite 참고 문서](https://www.sqlite.org/lang_corefunc.html)
