"""주제(category) 꼬리표.

쪽 번호 → 주제 dict로 꼬리표를 붙인다. loader.py가 PAGE_CATEGORY_MAP.get(쪽 번호)로 읽는다.
쪽 번호는 PDF에 인쇄된 번호(1부터)다. metadata['page']는 0부터이므로 +1 해서 찾는다.
주제 키 7개는 config.ROUTER_PROMPT의 키와 같아야 한다(라우터가 고른 키로 필터 검색).

한 쪽에는 한 주제만 붙일 수 있어서, 주제가 섞인 쪽은 '그 쪽에서 비중이 큰 주제'로 정했다.
아래 쪽의 작은 부분은 주제 필터 검색에서 빠질 수 있다(서울대학교 학칙 2022.2.23 기준).
   2쪽: general            ← 제12조(총장)·제13조(부총장)는 organization
  12쪽: calendar_admission ← 제48조의6(시흥캠퍼스 발전위원회)은 organization
  15쪽: calendar_admission ← 제66조 ①② (휴학 신청 기한)은 status_curriculum
  19쪽: status_curriculum  ← 제84조(시험)·제85조 ①(성적평가)은 exam_graduation
  23쪽: tuition_discipline ← 제101조(학생의 의무)·제102조(간행물)는 special
"""

# 주제 키 → 화면에 보여줄 이름
# 꼬리표는 쪽 단위로 붙으므로, 괄호 안 범위는 PAGE_CATEGORY_MAP·PAGE_ARTICLES 기준 실제 범위다.
CATEGORY_NAMES = {
    "general":            "총칙·교육조직·교원 (1~2쪽, 제1~13조)",
    "organization":       "총장·처·위원회·부속시설 (3~11쪽, 제13~48조의6)",
    "calendar_admission": "학기·수업연한·입학·편입학·전과 (12~15쪽, 제48조의6~66조)",
    "status_curriculum":  "휴학·복학·제적·수강·학점·전공이수·졸업학점 (16~19쪽, 제66~85조)",
    "exam_graduation":    "성적·수료·졸업·학위 (20~21쪽, 제85~90조)",
    "special":            "계절수업·공개강좌·위탁생·학생회 (22쪽, 제91~100조)",
    "tuition_discipline": "학생의무·장학·징계·학사경고·유급·등록금·학칙개정 (23~25쪽, 제101~119조)",
}


# 쪽 번호 → 주제
PAGE_CATEGORY_MAP = {
    1: "general", 2: "general",
    3: "organization", 4: "organization", 5: "organization", 6: "organization", 7: "organization",
    8: "organization", 9: "organization", 10: "organization", 11: "organization",
    12: "calendar_admission", 13: "calendar_admission", 14: "calendar_admission", 15: "calendar_admission",
    16: "status_curriculum", 17: "status_curriculum", 18: "status_curriculum", 19: "status_curriculum",
    20: "exam_graduation", 21: "exam_graduation",
    22: "special",
    23: "tuition_discipline", 24: "tuition_discipline", 25: "tuition_discipline",
}

# 쪽 번호 → 그 쪽에 걸쳐 있는 조 (출처를 "18쪽 · 제76~78조"처럼 보여줄 때 쓴다)
PAGE_ARTICLES = {
    1: "제1~5조", 2: "제5~13조", 3: "제13~19조", 4: "제19~23조", 5: "제23~27조",
    6: "제27조의2~33조", 7: "제33~39조", 8: "제39~42조", 9: "제42~45조", 10: "제45~48조의2",
    11: "제48조의2~48조의6", 12: "제48조의6~52조", 13: "제52~55조", 14: "제56~62조",
    15: "제62~66조", 16: "제66~69조", 17: "제69~75조", 18: "제76~78조", 19: "제78~85조",
    20: "제85~86조", 21: "제87~90조", 22: "제91~100조", 23: "제101~108조",
    24: "제109~117조", 25: "제117~119조",
}
