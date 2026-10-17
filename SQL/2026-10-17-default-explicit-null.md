# DEFAULT는 생략한 값에 적용된다

추가 학습 정리일: 2026-10-17

자체 가상 데이터로 확장한 SQLite 실습이다. 각 글의 코드는 새로운 임시 메모리 DB에서 실행했으며 실제 서비스 데이터에 적용하지 않았다. MySQL 동작을 검증한 기록은 아니다.

## 실행 예제

```sql
CREATE TABLE jobs(id INTEGER PRIMARY KEY,state TEXT DEFAULT 'ready');
INSERT INTO jobs(id) VALUES(1);
INSERT INTO jobs(id,state) VALUES(2,NULL);
SELECT id,state FROM jobs ORDER BY id;
```

조회 결과(행 배열): `[[1,"ready"],[2,null]]`

상태를 생략한 1번에는 ready가 들어간다. NULL을 명시한 2번은 NULL을 유지한다.

## 적용할 때 확인할 점

기본값은 이미 저장된 NULL을 자동으로 채우는 기능이 아니다. 애플리케이션이 컬럼을 생략하는지, NULL을 전달하는지에 따라 결과가 다르므로 저장 요청을 만들 때 구분해야 한다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_createtable.html)
