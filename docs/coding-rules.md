# 코딩 규칙

## 기본 원칙
- Flutter/Dart 표준 문법을 준수한다
- 코드 작성 후 반드시 유효성 검사를 진행한다 (flutter analyze)
- 코드 포맷팅을 적용한다 (dart format)
- analysis_options.yaml의 lint 규칙을 준수한다
- 경고(warning)와 에러(error)가 없는 상태를 유지한다
- deprecated된 API 사용을 피하고, 최신 권장 방식을 따른다
- 중복 코드를 허용하지 않는다 (공통 로직은 함수/클래스로 분리)
- 하드코딩을 금지한다 (값은 상수 또는 설정 파일로 관리)
- 매직 넘버/매직 문자열을 사용하지 않는다 (의미 있는 상수로 정의)
- 하나의 함수/메서드는 하나의 역할만 수행한다 (단일 책임 원칙)
- 함수/메서드가 너무 길어지면 분리한다
- 변수명과 함수명은 역할을 명확히 알 수 있도록 작성한다
- 사용하지 않는 코드와 주석 처리된 코드는 삭제한다
- 주석 없이도 이해할 수 있는 코드를 작성한다

## 네이밍 규칙
- 클래스명은 PascalCase를 사용한다 (예: UserModel, HomeScreen)
- 변수와 함수명은 camelCase를 사용한다 (예: userName, fetchData)
- 파일명은 snake_case를 사용한다 (예: user_model.dart)
- 상수는 SCREAMING_SNAKE_CASE를 사용한다 (예: API_BASE_URL)
- private 변수와 메서드는 언더스코어 접두사를 붙인다 (예: _privateMethod)

## 파일명 규칙
- Model 파일은 *_model.dart로 명명한다
- View 파일은 *_screen.dart 또는 *_widget.dart로 명명한다
- Controller 파일은 *_controller.dart로 명명한다
- Service 파일은 *_service.dart로 명명한다

## import 순서
- 첫 번째로 dart 내장 패키지를 import한다
- 두 번째로 flutter 패키지를 import한다
- 세 번째로 외부 패키지를 import한다
- 마지막으로 프로젝트 내부 파일을 import한다

## 주석 규칙
- 복잡한 비즈니스 로직에만 주석을 작성한다
- TODO 주석은 "// TODO: 설명" 형식을 사용한다
- 문서화 주석은 "///" 형식을 사용한다
