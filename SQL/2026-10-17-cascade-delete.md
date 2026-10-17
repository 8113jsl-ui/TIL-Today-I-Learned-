# ON DELETE CASCADE의 삭제 범위 확인하기

추가 학습 정리일: 2026-10-17

자체 가상 데이터로 확장한 SQLite 실습이다. 각 글의 코드는 새로운 임시 메모리 DB에서 실행했으며 실제 서비스 데이터에 적용하지 않았다. MySQL 동작을 검증한 기록은 아니다.

## 실행 예제

```sql
PRAGMA foreign_keys=ON;
CREATE TABLE teams(id INTEGER PRIMARY KEY);
CREATE TABLE people(id INTEGER PRIMARY KEY,team_id INTEGER REFERENCES teams(id) ON DELETE CASCADE);
INSERT INTO teams VALUES(1),(2);
INSERT INTO people VALUES(10,1),(11,1),(12,2);
DELETE FROM teams WHERE id=1;
SELECT id,team_id FROM people ORDER BY id;
```

조회 결과(행 배열): `[[12,2]]`

1번 팀 삭제와 함께 소속된 10·11번 사람 행도 사라진다. 2번 팀 소속인 12번은 남는다.

## 적용할 때 확인할 점

CASCADE는 연결을 NULL로 바꾸는 동작이 아니다. 소속만 해제하려는 업무라면 이 정책이 맞는지 다시 검토해야 한다. SQLite에서는 연결별 외래 키 활성화를 트랜잭션 시작 전에 확인한다. 예제의 삭제는 임시 메모리 DB에서만 실행했다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/foreignkeys.html)
