# RANK에서 공동 순위 다음 번호 확인하기

추가 학습 정리일: 2026-10-14

동점자에게 같은 순위를 주는 예제입니다. 점수에만 순위 기준을 두어 같은 점수끼리 묶이도록 해요.

기존 SQL 집계 학습을 확장한 자체 예제입니다. 수업에서 직접 다뤘다는 의미는 아니며, 아래 결과는 SQLite에서 검증합니다.

## 예제 준비

새 데이터베이스에서 실행하세요. 모든 글은 독립적으로 실행할 수 있도록 같은 작은 데이터를 사용합니다.

```sql
CREATE TABLE scores (
  id INTEGER PRIMARY KEY, team TEXT NOT NULL, points INTEGER NOT NULL
);
INSERT INTO scores VALUES
  (1, 'A', 90), (2, 'A', 90), (3, 'A', 70),
  (4, 'B', 80), (5, 'B', 60);
```

## 조회와 결과

```sql
SELECT id, points,
  RANK() OVER (ORDER BY points DESC) AS ranking
FROM scores ORDER BY points DESC, id;
```

```text
1 | 90 | 1
2 | 90 | 1
4 | 80 | 3
3 | 70 | 4
5 | 60 | 5
```

90점 두 행이 공동 1위이므로 80점은 3위입니다. 순위를 계산하는 OVER 안에 고유 id까지 넣으면 동점이 나뉘므로, 출력 정렬용 id는 바깥 ORDER BY에만 두었습니다. 상위 2위까지라는 조건은 두 개의 점수 구간을 뜻하지 않는다는 점도 결과에서 확인할 수 있어요.

## 참고

- [기존 집계 학습](sql-group-by-having-practice.md)
- [SQLite 공식 문서](https://www.sqlite.org/windowfunctions.html)
