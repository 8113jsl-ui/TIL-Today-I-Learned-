# 프로젝트 구조와 .gitignore, 환경변수 관리

학습일: 2026-08-27 · 정리일: 2026-09-24

수업 필기.txt의 해당 날짜 구간을 바탕으로 정리했다. 용어 설명과 예제는 복습을 위해 보완했으며 수업 전체 기록은 아니다.

## 구조를 먼저 정리하는 이유

필기의 Todo 앱 구조를 참고해 파일의 역할을 나눈다. 폴더 이름 자체보다 팀이 일관되게 사용할 책임 구분이 중요하다.

```text
todo-app/
├── README.md
├── requirements.txt
├── .gitignore
├── .env.example
├── routes/
├── static/
└── templates/
```

README에는 실행 방법과 검증 방법을, requirements.txt에는 의존성을 기록한다. routes는 요청 처리 코드를, static은 CSS·JavaScript 같은 정적 파일을, templates는 서버에서 렌더링할 템플릿을 담을 수 있다. 프로젝트 규모에 따라 구조는 달라질 수 있다.

## 점으로 시작하는 이름은 공개 방지 장치가 아니다

`.env`처럼 점으로 시작하는 파일도 Git에 추가하면 저장소에 올라갈 수 있다. 필기의 설명과 달리 파일명만으로 비밀 정보가 보호되지는 않는다.

`.gitignore`는 추적하지 않는 파일을 Git의 추적 대상에서 제외하는 규칙이다. 병합 충돌이나 LLM 연결 충돌을 방지하는 기능은 아니다. 이미 추적 중인 파일에도 자동 적용되지 않는다. [Git gitignore 문서](https://git-scm.com/docs/gitignore)

예제 규칙:

```gitignore
.venv/
__pycache__/
.env
.env.*
!.env.example
```

## 예시 파일과 실제 값 분리

`.env.example`에는 실제 키 대신 필요한 변수 이름과 빈 값만 남긴다.

```dotenv
SERVICE_API_KEY=
DATABASE_URL=
```

예시 파일을 복사했다는 것만으로 값이 자동 로드되지는 않는다. 애플리케이션에서 환경변수를 읽거나 사용하는 도구가 파일을 로드하도록 구성해야 한다.

## 커밋 전 확인

```bash
git status --short
git diff --cached
git check-ignore -v .env
```

이미 추적한 비밀 파일은 규칙 추가만으로 이력이 사라지지 않는다. 노출된 키는 폐기·재발급하고 필요하면 이력 정리도 별도로 검토해야 한다. 원본 필기의 수업 운영 정보와 비밀번호는 학습 코드나 공개 문서에 포함하지 않는다.
