# StaticFileServerShadowing

이 프로젝트는 C++17, Boost 및 GoogleTest를 사용한 정적 파일 서버 섀도잉(Static File Server Shadowing) 프로젝트입니다.

## 🚀 Nix로 시작하기

이 프로젝트는 **Nix**를 사용하여 모든 개발 환경(Clang, CMake, Boost, GTest, GDB)을 일관되게 관리합니다.

### 필수 조건

- [Nix](https://nixos.org/download.html)가 설치되어 있고, [Flakes](https://nixos.wiki/wiki/Flakes)가 활성화되어 있어야 합니다.

### 1. 개발 환경 진입

터미널에서 다음 명령어를 입력하면 필요한 모든 의존성이 포함된 개발 셸로 진입합니다.

```bash
nix develop
```

이 명령어를 실행하면:
- **Clang**이 기본 컴파일러로 설정됩니다.
- **Boost** 및 **GTest** 라이브러리가 환경에 추가됩니다.

## 🛠️ 빌드 방법

`nix develop` 셸 안에서 CMake를 사용하여 프로젝트를 빌드할 수 있습니다.

### 1. 프로젝트 구성 및 빌드

```bash
mkdir build && cd build
cmake ..
make
```

### 2. 테스트 실행

빌드 후에는 다음 명령어로 유닛 테스트를 실행할 수 있습니다.

```bash
# CTest를 이용한 테스트 실행
ctest

# 상세 로그와 함께 테스트 실행
ctest -V

# 실패한 테스트의 결과만 상세히 보기
ctest --output-on-failure

# 테스트 실행 파일을 직접 실행
./tests/unit_tests
```

## 🏗️ 프로젝트 구조

- `flake.nix`: Nix Flake 개발 환경 설정 파일.
- `CMakeLists.txt`: 루트 CMake 설정 파일.
- `tests/`: GoogleTest를 사용한 유닛 테스트 디렉토리.
  - `test_streambuf.cpp`: 초기 커스텀 `streambuf` 구현 테스트.

## 🧪 포함된 개발 도구

`nix develop` 셸에는 다음 도구들이 포함되어 있습니다:
- **Compiler**: Clang (C++17)
- **Build System**: CMake
- **Debugger**: GDB
- **Libraries**: Boost, GoogleTest
