# LCEL 체인에서 질문의 두 경로

정리일: 2026-10-23. 실제 수업일은 미확인이다.

## 자료 범위

사용자가 제공한 로컬 실습 코드에 대한 복습 기록이다. 전체 수업 노션은 접근하지 못했으므로 강의 본문과의 대조는 아직 하지 않았다. 아래 스냅샷은 원본의 일부이며 독립 실행 프로젝트가 아니다. 팀 실습 코드의 단독 작성이나 전체 완성을 주장하지 않는다.

- [desktop-chat-pdf/src/rag/chain.py](../examples/2026-10-23-code-reading/desktop-chat-pdf/src/rag/chain.py)

## 코드에서 확인한 흐름

make_chatbot은 같은 입력을 retriever와 RunnablePassthrough에 보낸다. 검색 결과는 format_docs로 context가 되고 원래 입력은 question이 된다. 이후 프롬프트, 모델, 문자열 파서를 연결한다.

## 주의할 점

체인을 만드는 것과 invoke 또는 stream으로 실행하는 것은 다르다. 프롬프트에 선택 history가 있지만 현재 이 체인은 history를 공급하지 않는다. 대화 기억이 구현되어 있다고 해석하면 안 된다.

## 직접 확인할 문제

context와 question 각각에 어떤 값이 들어가는지 화살표로 설명하기.

## 검증 범위

첨부한 Python 파일의 AST 문법 검사를 통과했다. 라이브러리 의존성 설치·실제 API 호출·PDF 처리 통합 테스트는 하지 않았다. 설명에 적은 미구현 함수는 그대로 보존했다.
