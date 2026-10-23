"""[4] 임베딩·벡터DB: ③ Embed → ④ Store"""

from langchain_chroma import Chroma


def build_db(pdf_path: str | None, openai_key: str) -> tuple[Chroma | None, str]:
    """PDF → 벡터DB. 반환값은 (db, 상태 메시지).

    - 이벤트의 outputs=[db_state, status] 순서와 일치해야 한다
    - 키가 없으면 (None, 경고 메시지), pdf_path가 None이면 (None, "")
    - 업로드마다 새 collection_name(uuid)을 써서 이전 PDF와 섞이지 않게 한다
    - 청크 분할은 loader.load_and_split()를 호출한다
    """
    raise NotImplementedError
