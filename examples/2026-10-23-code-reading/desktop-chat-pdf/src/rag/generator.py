"""[6] 생성·스트리밍: ⑥ Generate"""

from collections.abc import Iterator

from langchain_chroma import Chroma


def answer(question: str, openai_key: str, db: Chroma | None) -> Iterator[str]:
    """Gradio에서 받은 질문을 처리하고 답변 조각을 순서대로 yield 한다.

    이 함수는 사용자 요청 한 건의 오케스트레이션 경계다. 입력을 검증하고,
    openai_key와 config.GENERATE_MODEL로 언어 모델을 준비한 뒤,
    retriever.get_retriever()로 검색기를 생성하고 chain.make_chatbot()에 전달한다.
    프롬프트 문구는 prompt.get_prompt()가 관리하므로 이 함수에서 직접 작성하지 않는다.

    Args:
        question: 사용자가 입력한 자연어 질문. 공백만 있는 문자열은 유효한 질문으로
            취급하지 않는다.
        openai_key: Gradio의 비밀번호 입력란에서 전달되는 OpenAI API 키. 모델 생성에
            사용하고 로그나 화면에 출력하지 않는다.
        db: 업로드 이벤트에서 build_db()가 만든 Chroma 벡터DB. None이면 아직 PDF가
            준비되지 않은 상태이므로 답변을 시작하지 않는다.

    Yields:
        생성 중인 답변의 누적 텍스트. 예를 들어 첫 조각이 ``"환불은"``, 다음 조각이
        ``" 구매 후 가능합니다."``라면 두 번째 yield는 ``"환불은 구매 후 가능합니다."``
        형태다. Gradio는 yield마다 화면을 갱신한다.

    Raises:
        gr.Error: API 키가 없거나, db가 None이거나, 질문이 비어 있는 경우 사용자에게
            UI 오류를 표시한다. 모델/API 호출 실패도 숨기지 않고 상위로 전달한다.
    """
    raise NotImplementedError
