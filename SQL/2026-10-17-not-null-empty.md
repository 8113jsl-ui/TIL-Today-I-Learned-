# NOT NULL은 빈 문자열까지 막지 않는다

추가 학습 정리일: 2026-10-17

자체 가상 데이터로 확장한 SQLite 실습이다. 각 글의 코드는 새로운 임시 메모리 DB에서 실행했으며 실제 서비스 데이터에 적용하지 않았다. MySQL 동작을 검증한 기록은 아니다.

## 실행 예제

```sql
CREATE TABLE notes(title TEXT NOT NULL);
INSERT INTO notes VALUES('');
SELECT title FROM notes;
```

조회 결과(행 배열): `[[""]]`

NULL은 거부되지만 빈 문자열은 저장된다. 필수 입력이라는 업무 규칙이 공백까지 금지한다면 별도 검사가 필요하다.

다음 문장은 별도로 실행하면 제약 위반 오류가 발생한다.

```sql
INSERT INTO notes VALUES(NULL);
```

## 적용할 때 확인할 점

이번 예제는 입력값이 없다는 표현 중 NULL만 제한한다. 빈 문자열과 공백 문자열을 같은 것으로 취급할지 먼저 정하고, 화면의 검사와 DB의 제약을 맞춰야 한다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_createtable.html)
