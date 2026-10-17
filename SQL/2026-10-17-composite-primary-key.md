# 복합 기본 키는 컬럼 조합의 중복을 막는다

추가 학습 정리일: 2026-10-17

자체 가상 데이터로 확장한 SQLite 실습이다. 각 글의 코드는 새로운 임시 메모리 DB에서 실행했으며 실제 서비스 데이터에 적용하지 않았다. MySQL 동작을 검증한 기록은 아니다.

## 실행 예제

```sql
CREATE TABLE enrollment(student_id INTEGER NOT NULL,course_id INTEGER NOT NULL,PRIMARY KEY(student_id,course_id));
INSERT INTO enrollment VALUES(1,10),(1,20),(2,10);
SELECT student_id,course_id FROM enrollment ORDER BY student_id,course_id;
```

조회 결과(행 배열): `[[1,10],[1,20],[2,10]]`

학생 한 명이 여러 강좌에 등록할 수 있고 같은 강좌에 여러 학생이 들어갈 수 있다. 같은 학생·강좌 조합의 재등록만 거부된다.

다음 문장은 별도로 실행하면 제약 위반 오류가 발생한다.

```sql
INSERT INTO enrollment VALUES(1,10);
```

## 적용할 때 확인할 점

각 컬럼이 따로 유일하다는 뜻은 아니다. SQLite의 일반 테이블에서 기본 키의 NULL 관련 예외에 의존하지 않도록 두 컬럼에 NOT NULL을 명시했다. 어떤 조합을 하나의 기록으로 보는지 설계가 먼저다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_createtable.html)
