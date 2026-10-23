# PDF 로더의 계약과 미구현 상태

정리일: 2026-10-23. 실제 수업일은 미확인이다.

## 자료 범위

사용자가 제공한 로컬 실습 코드에 대한 복습 기록이다. 전체 수업 노션은 접근하지 못했으므로 강의 본문과의 대조는 아직 하지 않았다. 아래 스냅샷은 원본의 일부이며 독립 실행 프로젝트가 아니다. 팀 실습 코드의 단독 작성이나 전체 완성을 주장하지 않는다.

- [desktop-chat-pdf/src/db/loader.py](../examples/2026-10-23-code-reading/desktop-chat-pdf/src/db/loader.py)

## 코드에서 확인한 흐름

load_and_split은 PDF 경로를 받아 Document 목록을 반환하는 인터페이스다. 주석은 PyPDFLoader와 RecursiveCharacterTextSplitter, 공통 청크 설정을 사용할 계획을 설명한다.

## 주의할 점

함수 본문은 NotImplementedError다. PDF를 읽거나 청크를 만든 결과는 아직 없다. 주석의 예정 동작과 실제 구현을 구분해야 한다. 스캔 PDF는 텍스트 추출 이후 별도 OCR 검토가 필요할 수 있다.

## 직접 확인할 문제

구현 후 빈 PDF·여러 페이지·메타데이터 보존을 어떤 입력으로 확인할지 적기.

## 검증 범위

첨부한 Python 파일의 AST 문법 검사를 통과했다. 라이브러리 의존성 설치·실제 API 호출·PDF 처리 통합 테스트는 하지 않았다. 설명에 적은 미구현 함수는 그대로 보존했다.
