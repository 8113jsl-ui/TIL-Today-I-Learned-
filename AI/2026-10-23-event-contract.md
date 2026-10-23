# Gradio 이벤트와 함수 인자 순서

정리일: 2026-10-23. 실제 수업일은 미확인이다.

## 자료 범위

사용자가 제공한 로컬 실습 코드에 대한 복습 기록이다. 전체 수업 노션은 접근하지 못했으므로 강의 본문과의 대조는 아직 하지 않았다. 아래 스냅샷은 원본의 일부이며 독립 실행 프로젝트가 아니다. 팀 실습 코드의 단독 작성이나 전체 완성을 주장하지 않는다.

- [desktop-chat-pdf/app.py](../examples/2026-10-23-code-reading/desktop-chat-pdf/app.py)
- [desktop-chat-pdf/src/config.py](../examples/2026-10-23-code-reading/desktop-chat-pdf/src/config.py)

## 코드에서 확인한 흐름

app.py는 PDF 업로드를 build_db에 연결하고 반환값을 db_state와 status 순서로 받는다. 질문 버튼과 Enter는 같은 answer 함수를 호출한다.

## 주의할 점

inputs 배열은 함수 인자 순서와 맞아야 한다. 화면을 구성했다고 PDF 처리까지 완성된 것은 아니다. config의 청크 크기 100과 overlap 20은 현재 설정값이며 최적값을 검증한 결과가 아니다.

## 직접 확인할 문제

업로드 입력 두 개와 반환값 두 개를 코드에서 짝지어 보기.

## 검증 범위

첨부한 Python 파일의 AST 문법 검사를 통과했다. 라이브러리 의존성 설치·실제 API 호출·PDF 처리 통합 테스트는 하지 않았다. 설명에 적은 미구현 함수는 그대로 보존했다.
