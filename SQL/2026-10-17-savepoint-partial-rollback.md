# SAVEPOINT 이후의 변경만 취소하기

추가 학습 정리일: 2026-10-17

자체 가상 데이터로 확장한 SQLite 실습이다. 각 글의 코드는 새로운 임시 메모리 DB에서 실행했으며 실제 서비스 데이터에 적용하지 않았다. MySQL 동작을 검증한 기록은 아니다.

## 실행 예제

```sql
CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT);
BEGIN;
INSERT INTO tasks VALUES(1,'keep');
SAVEPOINT draft;
INSERT INTO tasks VALUES(2,'discard');
ROLLBACK TO draft;
RELEASE draft;
COMMIT;
SELECT id,title FROM tasks ORDER BY id;
```

조회 결과(행 배열): `[[1,"keep"]]`

저장점 이전에 삽입한 1번은 남고 이후의 2번만 취소된다. ROLLBACK TO는 바깥 트랜잭션 자체를 끝내지 않는다.

## 적용할 때 확인할 점

이 예제에서 RELEASE는 저장점 표시를 제거하며 바깥 BEGIN의 변경 확정은 마지막 COMMIT이 담당한다. 저장점을 독립된 영구 저장으로 생각하면 안 된다. 아직 바깥 트랜잭션을 취소하면 1번도 사라질 수 있다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_savepoint.html)
