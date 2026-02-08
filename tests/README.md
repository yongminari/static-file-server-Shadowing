# Unit Test Guide

이 프로젝트는 **GoogleTest (GTest)** 프레임워크와 CMake의 **CTest**를 사용하여 유닛 테스트를 관리합니다.

## 🏗️ 테스트 환경 구축 원리

1.  **테스트 활성화**: 루트 `CMakeLists.txt`에서 `enable_testing()` 함수를 호출합니다.
    *   이 명령은 빌드 디렉토리에 `CTestTestfile.cmake` 파일을 생성하여 테스트 환경을 초기화합니다.
2.  **테스트 등록**: 하위 디렉토리(예: `tests/`)의 `CMakeLists.txt`에서 `add_test()`를 호출하여 개별 테스트 실행 파일을 등록합니다.
3.  **통합 관리**: `add_test`로 등록된 모든 테스트는 루트의 CTest 설정에 통합되어, 단일 명령으로 프로젝트 전체 테스트를 수행할 수 있게 됩니다.

## 🚀 테스트 실행 방법

모든 테스트 명령은 빌드 출력 디렉토리(예: `build/`) 내에서 실행해야 합니다.

### 1. 전체 테스트 실행
```bash
ctest
```

### 2. 상세 결과 확인 (Verbose)
테스트 결과 요약뿐만 아니라, GTest의 상세한 로그(표준 출력)를 확인하려면 `-V` 옵션을 사용합니다.
```bash
ctest -V
```

### 3. 특정 테스트만 실행
특정 이름이 포함된 테스트만 골라서 실행하려면 `-R` (Regex) 옵션을 사용합니다.
```bash
# 이름에 'streambuf_test'가 포함된 테스트만 실행
ctest -R streambuf_test
```

### 4. 실패 시 상세 로그 출력
테스트가 실패했을 때만 원인을 확인하기 위해 로그를 출력하고 싶다면 다음 옵션이 유용합니다.
```bash
ctest --output-on-failure
```

---
**Tip**: GTest 바이너리(`unit_tests`)를 직접 실행하면 CTest를 거치지 않은 GTest 본연의 컬러 출력과 상세 로그를 즉시 확인할 수 있습니다.