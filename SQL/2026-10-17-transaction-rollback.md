# ROLLBACK으로 미확정 변경 되돌리기

추가 학습 정리일: 2026-10-17

자체 가상 데이터로 확장한 SQLite 실습이다. 각 글의 코드는 새로운 임시 메모리 DB에서 실행했으며 실제 서비스 데이터에 적용하지 않았다. MySQL 동작을 검증한 기록은 아니다.

## 실행 예제

```sql
CREATE TABLE items(id INTEGER PRIMARY KEY,qty INTEGER);
INSERT INTO items VALUES(1,10),(2,20);
BEGIN;
UPDATE items SET qty=qty+5;
INSERT INTO items VALUES(3,30);
ROLLBACK;
SELECT id,qty FROM items ORDER BY id;
```

조회 결과(행 배열): `[[1,10],[2,20]]`

수량 변경과 새 행 삽입이 모두 취소되어 처음 상태로 돌아온다. ROLLBACK 이전에 COMMIT했다면 같은 방식으로 확정된 변경을 되돌릴 수는 없다.

## 적용할 때 확인할 점

사용자의 취소 요청을 처리할 때 현재 트랜잭션의 범위를 알아야 한다. 외부로 보낸 이메일이나 파일 변경 같은 동작까지 DB의 ROLLBACK이 취소하는 것은 아니다. 어떤 작업이 같은 원자적 단위에 속하는지 구분한다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_transaction.html)
