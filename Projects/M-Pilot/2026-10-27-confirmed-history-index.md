# 검색 이력에는 확정된 조치만 넣기

정리일: 2026-10-27

## 확인한 자료

- `mpilot-handoff/mpilot-handoff/code/feature-vectordb-rebuild-index/mpilot/db/vectordb.py: _history_document, index_history`
- `mpilot-handoff/mpilot-handoff/code/feature-vectordb-rebuild-index/tests/test_vectordb_indexing.py`

위 경로는 제공받은 로컬 폴더 기준이다. 현재 프로젝트와 기능별 인계본을 구분하며, 인계본의 병합 여부는 확인하지 않았다.

## 코드에서 확인한 내용

_history_document는 조치 기록, 지원 경로, 완료 상태, 완료 시각을 확인한다. ID는 case_id를 기반으로 만들고 index_history가 해당 ID와 문서를 저장소에 전달한다.

## 배운 점

대화나 임시 안내를 확정 이력과 섞지 않으면 검색 결과가 실제 현장 조치인지 구분할 수 있다. 같은 사건의 안정된 ID는 반복 반영 시 중복 문서를 막는 upsert 설계의 기반이 된다.

## 검증 범위와 주의점

호출 코드는 add_documents에 같은 ID를 전달한다. 실제 덮어쓰기 동작은 저장소 구현에도 의존한다. 관련 upsert 테스트 함수가 있지만 이번 작업에서 실행한 것은 아니다.

소스와 테스트 정의를 읽어 정리했다. 앱 실행, DB 연결, API 호출, 테스트 실행은 하지 않았으며 원본 프로젝트 파일을 수정하지 않았다. 팀 프로젝트 전체의 단독 구현을 주장하는 기록이 아니다.

## 복습 질문

진행 중인 건과 조치 기록 없는 건이 검색 이력에 들어가면 어떤 문제가 생기는지 설명하기.
