# [Git/GitHub] GitHub Flow와 Git Flow, PR의 역할 정리

학습일: 2026-09-22 · 정리일: 2026-09-24  
필기: [20260922 : 깃허브 특강2](https://app.notion.com/p/20260922-2-3e32692e46ac808db8f2cedf94279e79)

수업 필기에 남긴 주제는 GitHub Flow, Git Flow, Pull Request(PR)다. 이 글은 해당 주제를 중심으로 복습한 기록이다. 브랜치의 역할과 명령어 예제는 공식 문서 등을 참고해 보충했으며, 수업 전체 내용을 옮긴 것은 아니다.

## 1. 브랜치 전략을 정하는 이유

같은 프로젝트에서 여러 사람이 작업하면 아직 완성되지 않은 변경과 배포할 변경을 구분할 필요가 있다. 브랜치 전략은 작업을 어디에서 시작하고, 검토한 결과를 어느 브랜치로 합칠지 정하는 약속이다.

Git은 변경 이력을 관리하는 도구이고, GitHub는 저장소 호스팅과 PR 같은 협업 기능을 제공한다. GitHub Flow와 Git Flow는 이 도구들로 협업하는 작업 방식이다.

## 2. GitHub Flow: 짧게 작업하고 검토 후 합치기

GitHub Flow는 기본 브랜치에서 작업 브랜치를 만들고, 변경을 검토한 뒤 다시 합치는 간결한 방식이다.

1. 최신 `main`에서 작업 브랜치를 만든다.
2. 작업 내용을 작은 단위로 커밋하고 원격 작업 브랜치에 push한다.
3. PR을 열어 변경 목적과 확인 방법을 설명한다.
4. 리뷰 의견을 반영하고 필요한 검사를 통과한다.
5. 변경을 `main`에 merge하고 사용이 끝난 작업 브랜치를 정리한다.

PR을 연 뒤에도 같은 작업 브랜치에 커밋을 추가하면 PR에 반영된다. 미완성 작업은 Draft PR로 먼저 공유할 수도 있다. [GitHub Flow 공식 문서](https://docs.github.com/en/get-started/using-github/github-flow)

```text
main에서 분기
  → 작업 브랜치에서 수정·commit
  → 작업 브랜치에 push
  → PR·리뷰·검사
  → main에 merge
```

이 흐름에서 기본 브랜치의 안정성을 유지하는 것은 팀의 검토·검증 절차에 달려 있다. 브랜치를 나눈다고 변경 내용이 자동으로 검증되지는 않는다.

## 3. Git Flow: 개발과 릴리스 준비를 나누기

Git Flow는 장기 유지 브랜치와 목적별 보조 브랜치를 구분한다. 원문 도표의 `master`는 여기서 `main`으로 표기한다.

| 브랜치 | 역할 | 일반적인 출발점과 반영 대상 |
| --- | --- | --- |
| `main` | 릴리스한 상태를 관리 | 릴리스 결과와 긴급 수정 반영 |
| `develop` | 다음 릴리스를 위한 개발 통합 | 기능 개발 결과를 모음 |
| `feature/*` | 개별 기능 개발 | `develop`에서 시작해 `develop`으로 병합 |
| `release/*` | 릴리스 직전 안정화와 버전 준비 | `develop`에서 시작해 `main`과 `develop`에 반영 |
| `hotfix/*` | 운영 버전의 긴급 오류 수정 | `main`에서 시작해 `main`과 개발 흐름에 반영 |

진행 중인 release 브랜치가 있다면 hotfix를 그 release에 반영하는 경우도 있다. 핵심은 긴급 수정이 다음 버전에서 빠지지 않도록 개발 흐름에도 전달하는 것이다.

Git Flow는 명시적인 버전 출시와 여러 버전 지원이 필요한 상황에 맞춰 생각해볼 수 있다. 반면 자주 배포하는 서비스에 항상 필요한 구조는 아니다. 제안자도 지속적 배포에는 더 단순한 흐름을 검토하라고 덧붙였다. [Git Flow 원문과 저자의 보충 설명](https://nvie.com/posts/a-successful-git-branching-model/)

| 비교 기준 | GitHub Flow | Git Flow |
| --- | --- | --- |
| 기본 구조 | 기본 브랜치와 작업 브랜치 | `main`, `develop`과 목적별 보조 브랜치 |
| 변경 통합 | 작업별 검토 후 기본 브랜치에 반영 | 기능 통합과 릴리스 준비를 구분 |
| 운영 부담 | 비교적 단순 | 브랜치 사이의 수정 반영을 더 신경 써야 함 |

팀 규모만으로 전략을 고르기보다는 배포 주기, 유지할 버전 수, 검토 절차를 함께 봐야 한다.

## 4. PR은 push 승인과 다르다

필기에서 보완할 부분은 PR과 push의 관계다. PR은 **작업 브랜치의 변경을 대상 브랜치에 합쳐 달라는 검토·병합 요청**이다. push는 로컬 커밋을 원격 브랜치에 보내는 동작이다.

| 용어 | 의미 |
| --- | --- |
| `commit` | 준비한 변경을 로컬 이력에 기록 |
| `push` | 로컬 커밋과 관련 객체를 원격에 보내 브랜치 등을 갱신 |
| PR | 두 브랜치 사이의 변경을 검토하고 병합을 제안 |
| `merge` | 다른 개발 흐름의 변경을 현재 브랜치에 통합 |

일반적인 협업에서는 **작업 브랜치에 먼저 push해야 동료가 그 변경을 PR로 검토할 수 있다.** `feature/login`에 push하는 것과 `main`에 변경을 반영하는 것은 구분해야 한다. [Git push 문서](https://git-scm.com/docs/git-push), [GitHub PR 문서](https://docs.github.com/en/pull-requests/reference/pull-requests)

또한 PR 자체가 모든 팀원의 승인을 요구하지는 않는다. 승인 수, 필수 검사, 코드 소유자 리뷰 등의 조건은 저장소의 브랜치 보호 규칙이나 ruleset으로 정한다. PR을 사용하는 것과 승인을 강제하는 설정은 별개다. 예를 들어 팀이 승인 1명과 테스트 통과를 요구하도록 설정하면 해당 조건이 병합 기준이 된다. [보호 브랜치 공식 문서](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)

## 5. 보충 예제: TIL 문서를 작업 브랜치에 올리기

다음은 GitHub Flow를 이해하기 위한 별도 예제다. 이미 복제한 저장소에 `main`과 `origin`이 있고, 원격 작업 브랜치에 쓰기 권한이 있다는 전제다. 이번 문서의 실제 게시 방식을 설명하는 명령은 아니다.

먼저 현재 브랜치와 미커밋 변경을 확인한다. 남아 있는 작업이 있다면 먼저 정리한다.

```bash
git status
git switch main
git pull --ff-only origin main
git switch -c docs/git-flow-review
```

`--ff-only`는 로컬과 원격 이력이 갈라졌을 때 자동으로 병합 커밋을 만들지 않고 중단한다. 실패하면 이력 차이를 확인해야 한다. [Git pull 문서](https://git-scm.com/docs/git-pull)

편집기에서 `Git-GitHub/git-flow-review.md`를 작성한 다음 실행한다.

```bash
git add Git-GitHub/git-flow-review.md
git diff --cached
git commit -m "docs: summarize GitHub Flow and pull requests"
git push -u origin docs/git-flow-review
```

`git diff --cached`로 커밋에 들어갈 내용을 확인한다. 첫 push의 `-u`는 원격 브랜치를 추적 대상으로 연결한다.

이후 GitHub에서 base를 `main`, compare를 `docs/git-flow-review`로 지정해 PR을 연다. 제목과 본문에는 변경 이유, 주요 내용, 확인한 사항을 적는다. 리뷰에 따른 수정도 같은 브랜치에 커밋하고 push한다.

예제 검증은 로컬 임시 저장소와 bare 원격 저장소에서 진행했다. 작업 브랜치에 커밋을 push해도 `main`의 커밋과 파일은 그대로 유지되는지 확인했다. GitHub PR 생성과 승인 규칙은 이 로컬 검증에 포함하지 않았다.

## 6. 복습할 때 구분할 점

- 작업 브랜치를 만드는 것과 원격에 올리는 것은 별도 단계다.
- push했다고 기본 브랜치에 자동으로 병합되지는 않는다.
- PR은 변경을 검토할 공간이며, 필수 승인 조건은 저장소 설정으로 정한다.
- GitHub Flow와 Git Flow는 우열보다 배포 방식과 관리할 버전에 맞춰 선택한다.
