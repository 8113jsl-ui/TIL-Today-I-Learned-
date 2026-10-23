"""[2] 진입점: 화면(ui) + 처리 함수(store, generator)를 이벤트로 연결한다."""

import gradio as gr

from src import ui
from src.db.store import build_db
from src.rag.generator import answer

with gr.Blocks(title="ChatPDF") as demo:
    c = ui.render()

    # inputs 순서 = 함수 매개변수 순서, outputs 순서 = 반환값 순서
    c.pdf_file.upload(build_db, inputs=[c.pdf_file, c.openai_key], outputs=[c.db_state, c.status])
    ask_inputs = [c.question, c.openai_key, c.db_state]
    c.ask_btn.click(answer, inputs=ask_inputs, outputs=c.output)
    c.question.submit(answer, inputs=ask_inputs, outputs=c.output)

if __name__ == "__main__":
    demo.launch()
