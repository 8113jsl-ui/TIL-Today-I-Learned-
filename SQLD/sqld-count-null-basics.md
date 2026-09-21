# [SQLD] COUNT(*)와 COUNT(컬럼), NULL이 있으면 왜 다를까?

원문: [Velog](https://velog.io/@8113jsl-ai/sqld-count-null-basics)

SQLD를 공부하면서 함께 정리해두면 좋은 개념이 COUNT(*)와 COUNT(컬럼)의 차이예요. 둘 다 개수를 세지만 NULL이 섞이면 결과가 달라집니다. 작은 표를 놓고 하나씩 세어볼게요.

아래 데이터는 교재나 기출문제를 옮긴 것이 아니라 별도로 구성한 학습 예제예요. SQLite에서 결과를 확인했으며, 특정 시험 회차에 출제된 문제를 설명하는 글은 아닙니다.

## 네 줄인데 왜 결과가 다를까요?

점수가 80, NULL, 0, 80으로 기록되어 있다고 해볼게요. 여러 집계 함수를 한 번에 실행하면 차이를 비교하기 좋습니다.

```sql
CREATE TABLE scores (score INTEGER);
INSERT INTO scores VALUES (80), (NULL), (0), (80);

SELECT
  COUNT(*) AS row_count,
  COUNT(score) AS value_count,
  COUNT(DISTINCT score) AS distinct_count,
  SUM(score) AS total_score,
  AVG(score) AS average_score
FROM scores;
```

실행 결과는 이렇게 나왔어요.

| 항목 | 결과 |
| --- | ---: |
| COUNT(*) | 4 |
| COUNT(score) | 3 |
| COUNT(DISTINCT score) | 2 |
| SUM(score) | 160 |
| AVG(score) | 약 53.3333 |

COUNT(*)는 행 자체를 세기 때문에 네 줄을 모두 포함해요. 반면 COUNT(score)는 score가 NULL이 아닌 행만 세어서 3이 됩니다.

COUNT(DISTINCT score)는 중복도 제외해요. NULL을 빼고 서로 다른 값을 찾아보면 80과 0만 남으니 결과가 2예요.

## 0점과 점수가 없는 건 달라요

여기서 0을 NULL처럼 생각하면 헷갈리기 쉬워요. 0은 실제로 기록된 값이어서 COUNT(score)에 포함됩니다.

이 예제의 NULL은 점수가 아직 기록되지 않은 상태라고 생각할 수 있어요. 점수를 모른다는 것과 실제로 0점을 받았다는 것은 다른 정보죠. 숫자만 보면 비슷하게 처리하고 싶어도, 데이터가 뜻하는 바부터 확인해야 합니다.

## 평균을 낼 때도 영향을 줍니다

AVG(score)는 NULL이 아닌 값들의 평균을 계산해요. 이번에는 (80 + 0 + 80) / 3이므로 약 53.3333이 됩니다. 전체 행 수인 4로 나누면 40이 되어 다른 결과가 나와요.

미기록 점수를 0으로 취급할지는 업무 규칙에 따라 결정해야 해요. 편하다는 이유로 바꾸면 평균이 담고 있는 의미까지 달라질 수 있습니다.

## 전부 NULL이면 어떻게 될까요?

NULL인 두 행만 있다면 COUNT(*)는 2, COUNT(score)는 0이에요. SQLite에서 SUM(score)와 AVG(score)는 NULL이 됩니다. 더할 값이나 평균을 낼 값이 없는 상태를 0과 구분하는 거예요.

집계 함수 문제를 볼 때는 먼저 전체 행을 세는지, 값이 있는 행만 세는지 확인해 보세요. 그다음 중복과 NULL을 차례로 살펴보면 결과를 따라가기가 한결 편합니다.

### 참고한 문서

- [SQLite 집계 함수 공식 문서](https://www.sqlite.org/lang_aggfunc.html)

