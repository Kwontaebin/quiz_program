# 테스트 규칙

## 테스트 종류

| 종류 | 대상 | 설명 |
|------|------|------|
| 단위 테스트 | Model, Controller, Service | 개별 클래스/함수의 로직 검증 |
| 위젯 테스트 | View (위젯) | UI 렌더링 및 사용자 상호작용 검증 |
| 통합 테스트 | 전체 앱 흐름 | 실제 시나리오 기반 E2E 검증 |

## 파일 위치 및 네이밍
- 테스트 파일은 test/ 폴더에 위치한다
- 원본 파일과 동일한 폴더 구조를 유지한다
- 파일명은 *_test.dart로 명명한다

```
lib/
├── controllers/user_controller.dart
├── services/user_service.dart
└── models/user_model.dart

test/
├── controllers/user_controller_test.dart
├── services/user_service_test.dart
└── models/user_model_test.dart
```

## 단위 테스트 규칙
- Controller의 상태 변경 로직을 테스트한다
- Service의 API 호출 결과를 테스트한다 (모킹 사용)
- Model의 fromJson, toJson 변환을 테스트한다
- 성공 케이스와 실패 케이스를 모두 작성한다

## 위젯 테스트 규칙
- 위젯이 올바르게 렌더링되는지 테스트한다
- 사용자 입력(탭, 입력 등)에 올바르게 반응하는지 테스트한다
- Controller는 모킹하여 UI만 독립적으로 테스트한다

## 모킹 규칙
- 모킹이란 테스트 시 실제 서버 호출 없이 응답값을 미리 정해두고 테스트하는 기법이다
- Service는 모킹하여 실제 API 호출을 하지 않는다
- mockito 또는 mocktail 패키지를 사용한다
- 모킹 클래스는 test/ 폴더 내 mocks/ 폴더에 위치한다

## 테스트 우선순위
1. Model (fromJson, toJson) - 데이터 변환 정확성
2. Controller - 비즈니스 로직 정확성
3. Service - API 호출 및 응답 처리
4. View - UI 렌더링 (시간 여유 시)

## 테스트 작성 시점
- 새 기능 개발 완료 후 테스트를 작성한다
- 버그 수정 시 해당 버그를 재현하는 테스트를 먼저 작성한다
- 기존 테스트가 통과하는지 확인 후 코드를 수정한다
