"""⑤ Retrieve: 벡터DB에서 질문과 관련 있는 Document를 찾고 문맥 문자열로 정리한다."""

import os
from collections.abc import Iterable
from typing import Any, Literal

from langchain.retrievers.multi_query import MultiQueryRetriever
from langchain_core.documents import Document
from langchain_core.language_models import BaseLanguageModel
from langchain_core.retrievers import BaseRetriever
from langchain_chroma import Chroma


RetrieverStrategy = Literal["similarity", "mmr", "multi_query"]


def get_retriever(
    db: Chroma,
    llm: BaseLanguageModel | None = None,
    *,
    strategy: RetrieverStrategy = "similarity",
    k: int = 4,
    fetch_k: int = 10,
    lambda_mult: float = 0.5,
    metadata_filter: dict[str, Any] | None = None,
) -> BaseRetriever:
    """요청한 전략에 맞는 LangChain 검색기를 만든다.

    Args:
        db: 검색할 Chroma 벡터 저장소. store.build_db()가 반환한 객체를 전달한다.
        llm: 질문을 여러 표현으로 확장하는 ``multi_query`` 전략에서 사용할 언어
            모델이다. similarity와 mmr에서는 사용하지 않으므로 생략할 수 있다.
        strategy: 검색 방법이다.
            - ``"similarity"``: 질문과 가장 가까운 청크 k개를 검색한다.
            - ``"mmr"``: fetch_k개 후보 중 서로 중복되지 않는 청크 k개를 고른다.
            - ``"multi_query"``: LLM으로 질문 표현을 확장해 기본 검색을 여러 번 하고
              결과를 합친다. LLM 호출이 추가되어 더 느리고 비용이 들 수 있다.
        k: 최종적으로 반환할 문서 수. similarity 및 multi_query의 검색 결과 수,
            또는 mmr이 선택하는 문서 수로 사용한다. 양수여야 한다.
        fetch_k: mmr 검색에서 다양성을 고려해 최종 선택 전에 검토할 후보 문서 수.
            ``k`` 이상이어야 하며, mmr 전략이 아닐 때는 사용하지 않는다.
        lambda_mult: mmr의 관련성/다양성 균형이다. 0에 가까울수록 다양성을,
            1에 가까울수록 질문과의 유사도를 우선한다. 0부터 1 사이여야 한다.
        metadata_filter: 검색 대상 메타데이터 조건이다. 예를 들어
            ``{"category": "refund"}``를 전달하면 해당 카테고리 문서만 검색한다.
            생략하거나 None이면 분류 필터 없이 검색한다.

    Returns:
        ``invoke(question: str)`` 호출 시 ``list[Document]``를 반환하는 검색기.
        결과 Document의 ``page_content``는 본문, ``metadata``는 출처 등 메타데이터다.

    Raises:
        ValueError: 검색 옵션이 유효하지 않거나 multi_query에 llm을 전달하지 않은 경우.

    Example:
        ``get_retriever(db, strategy="similarity", k=4)``
        ``get_retriever(db, strategy="similarity", metadata_filter={"category": "refund"})``
        ``get_retriever(db, llm, strategy="mmr", k=3, fetch_k=10)``
        ``get_retriever(db, llm, strategy="multi_query", k=4)``
    """
    if k < 1:
        raise ValueError("k는 1 이상이어야 합니다.")
    if strategy == "mmr":
        if fetch_k < k:
            raise ValueError("MMR의 fetch_k는 k 이상이어야 합니다.")
        if not 0 <= lambda_mult <= 1:
            raise ValueError("lambda_mult는 0과 1 사이여야 합니다.")
    if strategy == "multi_query" and llm is None:
        raise ValueError("multi_query 전략에는 llm이 필요합니다.")

    search_kwargs: dict[str, Any] = {"k": k}
    if metadata_filter is not None:
        search_kwargs["filter"] = metadata_filter

    if strategy == "mmr":
        search_kwargs.update(fetch_k=fetch_k, lambda_mult=lambda_mult)
        return db.as_retriever(search_type="mmr", search_kwargs=search_kwargs)

    base_retriever = db.as_retriever(search_kwargs=search_kwargs)
    if strategy == "multi_query":
        # 위에서 llm이 None이 아닌 경우를 검증했으므로 MultiQueryRetriever에 전달한다.
        return MultiQueryRetriever.from_llm(retriever=base_retriever, llm=llm)

    return base_retriever


def format_docs(docs: Iterable[Document]) -> str:
    """검색된 Document들을 프롬프트의 참고자료 칸에 넣을 문자열로 합친다.

    Args:
        docs: retriever.invoke(question)이 반환한 Document들의 iterable이다.
            각 문서의 ``page_content``를 본문으로 사용하고, metadata의 ``source``가
            있으면 파일 경로에서 파일명만 뽑아 출처 표시에 사용한다.

    Returns:
        문서마다 ``[출처: 파일명, p.페이지 번호]``와 본문을 붙인 뒤, 문서 사이를 빈 줄로 나눈
        하나의 문자열. 결과가 비어 있으면 빈 문자열을 반환한다.

    Note:
        이 함수는 문서 내용을 수정하거나 검색 결과를 추가/제거하지 않는다.
        출처 표시는 모델이 답변과 함께 표시할 수 있도록 참고자료 안에 제공한다.
    """
    blocks = []
    for doc in docs:
        source = doc.metadata.get("source")
        filename = os.path.basename(str(source)) if source else "문서"
        # PDF의 0부터 시작하는 페이지를 표시용 번호로 바꾼다.
        page = doc.metadata.get("page")
        page_text = f", p.{page + 1}" if type(page) is int and page >= 0 else ", 페이지 정보 없음"
        blocks.append(f"[출처: {filename}{page_text}]\n{doc.page_content}")
    return "\n\n".join(blocks)
