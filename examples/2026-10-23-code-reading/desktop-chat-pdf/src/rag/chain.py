"""RAG 검색기, 문서 포매터, 프롬프트, 언어 모델을 LCEL 체인으로 연결한다."""

# 언어 모델 인자의 타입을 표시하는 데 사용한다.
from langchain_core.language_models import BaseLanguageModel
# 모델 응답을 문자열로 바꾸는 출력 파서를 가져온다.
from langchain_core.output_parsers import StrOutputParser
# 검색기 인자의 타입을 표시하는 데 사용한다.
from langchain_core.retrievers import BaseRetriever
# 체인 타입과 입력을 그대로 전달하는 도구를 가져온다.
from langchain_core.runnables import Runnable, RunnablePassthrough

# 답변 규칙이 담긴 프롬프트 생성 함수를 가져온다.
from src.rag.prompt import get_prompt
# 검색한 문서 목록을 문자열로 바꾸는 함수를 가져온다.
from src.rag.retriever import format_docs


# 검색부터 답변 생성까지 연결하는 함수를 정의한다.
def make_chatbot(
    # 질문과 관련된 문서를 찾는 실제 검색기를 받는다.
    retriever: BaseRetriever,
    # 프롬프트를 받아 답변을 생성하는 실제 모델을 받는다.
    llm: BaseLanguageModel,
# 문자열을 입력받고 문자열을 출력하는 체인을 반환한다.
) -> Runnable[str, str]:
    """질문 문자열을 받아 답변 문자열을 반환하는 RAG 체인을 만든다.

    처리 순서:
        질문 → 문서 검색 → 문서 문자열화
             → 질문과 참고자료로 프롬프트 구성
             → 모델 응답 생성 → 문자열로 변환
    """
    # 체인을 구성해 반환하며, 여기서 답변을 생성하지는 않는다.
    return (
        # 같은 입력 질문을 두 경로로 보내 결과를 묶는다.
        {
            # ① 질문으로 문서를 검색하고, ② 문서 목록을 문자열로 변환한다.
            # |는 왼쪽 결과를 오른쪽 처리 단계로 전달한다.
            "context": retriever | format_docs,

            # ③ 입력 질문을 바꾸지 않고 그대로 전달한다.
            # 검색용 참고자료와 별도로 원래 질문을 보존한다.
            "question": RunnablePassthrough(),
        }  # context와 question을 담은 딕셔너리가 된다.
        # ④ context와 question을 받아 프롬프트를 구성한다.
        # 함수를 호출해 체인에서 사용할 프롬프트 객체를 얻는다.
        | get_prompt()
        # ⑤ 전달받은 언어 모델로 답변을 생성한다.
        # 앞 단계에서 완성한 프롬프트를 모델에 전달한다.
        | llm
        # ⑥ 모델 응답을 문자열로 변환한다.
        # 응답에서 텍스트를 꺼내 다음 코드가 쓰기 쉽게 만든다.
        | StrOutputParser()
    )  # 연결된 전체 체인을 반환한다.