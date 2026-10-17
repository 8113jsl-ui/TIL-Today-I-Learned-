# CHECK 비교식만으로 NULL을 금지할 수 없다

추가 학습 정리일: 2026-10-17

자체 가상 데이터로 확장한 SQLite 실습이다. 각 글의 코드는 새로운 임시 메모리 DB에서 실행했으며 실제 서비스 데이터에 적용하지 않았다. MySQL 동작을 검증한 기록은 아니다.

## 실행 예제

```sql
CREATE TABLE stock(qty INTEGER CHECK(qty>=0));
INSERT INTO stock VALUES(0),(NULL);
SELECT COUNT(*),COUNT(qty) FROM stock;
```

조회 결과(행 배열): `[[2,1]]`

음수는 거부되지만 NULL은 저장된다. SQLite의 CHECK는 식이 0일 때 위반으로 판단하며 NULL 결과는 이 조건만으로 거부하지 않는다.

다음 문장은 별도로 실행하면 제약 위반 오류가 발생한다.

```sql
INSERT INTO stock VALUES(-1);
```

## 적용할 때 확인할 점

재고가 반드시 숫자로 입력되어야 한다면 NOT NULL도 필요하다. 또한 일반 SQLite 테이블의 INTEGER 선언을 엄격한 타입 제한이라고 생각하면 안 된다. 이 예제는 정수와 NULL 입력만 검토한다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_createtable.html)
