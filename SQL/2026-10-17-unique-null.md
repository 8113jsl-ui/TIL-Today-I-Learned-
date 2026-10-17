# UNIQUE와 필수 입력은 다른 조건이다

추가 학습 정리일: 2026-10-17

자체 가상 데이터로 확장한 SQLite 실습이다. 각 글의 코드는 새로운 임시 메모리 DB에서 실행했으며 실제 서비스 데이터에 적용하지 않았다. MySQL 동작을 검증한 기록은 아니다.

## 실행 예제

```sql
CREATE TABLE members(email TEXT UNIQUE);
INSERT INTO members VALUES('a@example.com'),(NULL),(NULL);
SELECT COUNT(*),COUNT(email) FROM members;
```

조회 결과(행 배열): `[[3,1]]`

동일한 이메일은 거부되지만 SQLite에서는 UNIQUE 컬럼에 여러 NULL을 넣을 수 있다. 전체 세 행 중 이메일이 있는 행은 하나다.

다음 문장은 별도로 실행하면 제약 위반 오류가 발생한다.

```sql
INSERT INTO members VALUES('a@example.com');
```

## 적용할 때 확인할 점

이메일이 반드시 존재하면서 중복도 없어야 한다면 NOT NULL과 UNIQUE를 함께 검토한다. 문자열의 대소문자와 공백을 어떻게 정규화하는지는 이 제약만으로 정해지지 않는다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_createtable.html)
