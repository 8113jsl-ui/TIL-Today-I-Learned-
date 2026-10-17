# CREATE TABLE AS는 제약까지 복사하지 않는다

추가 학습 정리일: 2026-10-17

자체 가상 데이터로 확장한 SQLite 실습이다. 각 글의 코드는 새로운 임시 메모리 DB에서 실행했으며 실제 서비스 데이터에 적용하지 않았다. MySQL 동작을 검증한 기록은 아니다.

## 실행 예제

```sql
CREATE TABLE original(id INTEGER PRIMARY KEY,title TEXT NOT NULL);
INSERT INTO original VALUES(1,'first');
CREATE TABLE copied AS SELECT * FROM original;
INSERT INTO copied VALUES(1,NULL);
SELECT id,title FROM copied ORDER BY title IS NOT NULL,title;
```

조회 결과(행 배열): `[[1,null],[1,"first"]]`

SQLite의 CREATE TABLE AS SELECT로 만든 copied에는 원본의 기본 키와 NOT NULL 제약이 전달되지 않는다. 같은 id와 NULL 제목이 삽입되는 것으로 확인했다.

## 적용할 때 확인할 점

데이터가 복사됐다는 것과 스키마가 복제됐다는 것은 다르다. 백업이나 테스트 환경을 만들 때 인덱스·제약 등 필요한 정의를 별도로 확인해야 한다. 이 글의 결과를 다른 DB의 모든 복사 명령에 그대로 일반화하지 않는다.

## 참고

- [SQLite 공식 문서](https://www.sqlite.org/lang_createtable.html)
