# venv와 requirements.txt로 실행 환경 구분하기

학습일: 2026-08-26 · 정리일: 2026-09-24

수업 필기.txt의 해당 날짜 구간을 바탕으로 정리했다. 용어 설명과 예제는 복습을 위해 보완했으며 수업 전체 기록은 아니다.

## 가상환경을 만드는 이유

프로젝트마다 필요한 패키지와 버전이 다를 수 있다. 가상환경은 Python 프로젝트의 설치 공간을 분리하는 데 사용한다. 운영체제를 통째로 가상화하거나 신뢰할 수 없는 코드의 접근을 차단하는 보안 샌드박스는 아니다. [Python venv 문서](https://docs.python.org/3/library/venv.html)

## Windows PowerShell 예제

프로젝트 폴더에서 실행한다.

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
```

필기의 생성 경로는 `.venv`였으므로 활성화 경로도 같은 이름이어야 한다. `venv`와 `.venv`는 서로 다른 폴더명이다.

활성화가 환경 정책으로 제한되면 가상환경의 실행 파일을 직접 지정할 수 있다.

```powershell
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -c "import sys; print(sys.prefix != sys.base_prefix)"
```

마지막 결과가 True이면 해당 인터프리터가 가상환경에서 실행 중임을 확인할 수 있다.

## requirements.txt의 역할

`pip install -r requirements.txt`는 Python 파일 실행 명령이 아니라 의존성 설치 명령이다. 다음은 버전을 지정하는 형식의 예시다.

```text
package-name==1.2.3
```

위 이름은 형식 설명용이므로 그대로 설치하지 않는다. 실제 프로젝트에서 검증한 패키지와 버전을 기록한다.

가상환경 폴더 자체를 공유하기보다 의존성 명세와 실행 방법을 남긴다. 같은 명세라도 운영체제와 Python 버전 등에 영향을 받을 수 있으므로 실행 환경도 함께 기록해야 한다.
