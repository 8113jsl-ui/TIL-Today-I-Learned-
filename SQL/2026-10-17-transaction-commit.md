# 두 변경을 COMMIT으로 함께 확정하기

추가 학습 정리일: 2026-10-17

자체 가상 데이터로 확장한 SQLite 실습이다. 각 글의 코드는 새로운 임시 메모리 DB에서 실행했으며 실제 서비스 데이터에 적용하지 않았다. MySQL 동작을 검증한 기록은 아니다.

## 실행 예제

```sql
CREATE TABLE balances(id INTEGER PRIMARY KEY,amount INTEGER NOT NULL CHECK(amount>=0));
INSERT INTO balances VALUES(1,100),(2,0);
BEGIN;
UPDATE balances SET amount=amount-30 WHERE id=1;
UPDATE balances SET amount=amount+30 WHERE id=2;
COMMIT;
SELECT id,amount FROM balances ORDER BY id;
```

조회 결과(행 배열): `[[1,70],[2,30]]`

1번에서 30을 빼고 2번에 30을 더한 변경을 하나의 트랜잭션으로 확정한다. 합계는 100으로 유지된다.

## 적용할 때 확인할 점

복습용 포인트 이동이며 실제 금융 시스템 예제가 아니다. 실제 구현에서는 두 UPDATE가 대상 행을 찾았는지와 오류 발생 시 ROLLBACK도 확인해야 한다. 두 문장을 나란히 적기만 하는 것과 트랜잭션으로 묶는 것은 다르다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_transaction.html)
