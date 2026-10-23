# 검색 전략과 문서 출처 포맷

정리일: 2026-10-23. 실제 수업일은 미확인이다.

## 자료 범위

사용자가 제공한 로컬 실습 코드에 대한 복습 기록이다. 전체 수업 노션은 접근하지 못했으므로 강의 본문과의 대조는 아직 하지 않았다. 아래 스냅샷은 원본의 일부이며 독립 실행 프로젝트가 아니다. 팀 실습 코드의 단독 작성이나 전체 완성을 주장하지 않는다.

- [desktop-chat-pdf/src/rag/retriever.py](../examples/2026-10-23-code-reading/desktop-chat-pdf/src/rag/retriever.py)

## 코드에서 확인한 흐름

get_retriever는 similarity, mmr, multi_query 분기를 가진다. k, fetch_k, lambda_mult와 llm 여부를 일부 검증한다. format_docs는 source 파일명과 0부터 시작하는 page를 표시용 페이지로 바꾼다.

## 주의할 점

multi_query의 k는 기본 검색 한 번의 설정이다. 여러 검색의 합집합이 반드시 k개인 것은 아니다. 타입 힌트만으로 실행 시 임의의 strategy 문자열을 차단하지는 않는다. 현재 코드는 알려지지 않은 전략도 기본 검색으로 흘러갈 수 있다.

## 직접 확인할 문제

빈 문서 목록과 page=0의 출처 표시를 비교하기.

## 검증 범위

첨부한 Python 파일의 AST 문법 검사를 통과했다. 라이브러리 의존성 설치·실제 API 호출·PDF 처리 통합 테스트는 하지 않았다. 설명에 적은 미구현 함수는 그대로 보존했다.
