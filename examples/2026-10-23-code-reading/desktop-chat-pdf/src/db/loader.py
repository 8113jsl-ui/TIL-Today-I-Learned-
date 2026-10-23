"""[3] 문서 수집·분할: ① Load → ② Split"""

from langchain_core.documents import Document


def load_and_split(pdf_path: str) -> list[Document]:
    """PDF를 읽어 청크(Document) 리스트로 반환한다.

    - PyPDFLoader + RecursiveCharacterTextSplitter
    - 크기는 config.CHUNK_SIZE / CHUNK_OVERLAP 사용
    """
    raise NotImplementedError
