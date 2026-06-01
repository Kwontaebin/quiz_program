# Flutter 마이그레이션 프로젝트

## 필수 참고 문서
작업 시작 전 **반드시** `docs/` 디렉터리의 규칙 문서를 먼저 확인한다.
**모든 코드 작성 / 수정 작업마다** 관련 규칙을 `docs/` 에서 다시 확인 후 진행한다.

| 문서 | 내용 |
|------|------|
| `docs/coding-rules.md` | 코딩 규칙 (네이밍, 포맷, 주석 등) |
| `docs/mvc-rules.md` | MVC 패턴 적용 규칙 (Model / View / Controller 책임 분리) |
| `docs/package-rules.md` | 패키지 사용 규칙 (허용 패키지, 임의 추가 금지) |
| `docs/routing-rules.md` | go_router 라우팅 규칙 |
| `docs/error-handling.md` | 에러 처리 규칙 |
| `docs/test-rules.md` | 테스트 작성 규칙 |

## 프로젝트 개요
Java Android에서 Flutter로 마이그레이션하는 프로젝트이며, MVC 패턴을 사용한다.

## 기술 스택
- Flutter 3.x / Dart
- 아키텍처: MVC 패턴
- 상태관리: Provider
- 라우팅: go_router
- 전역 상태 저장: SharedPreferences (일반 데이터)
- 보안 저장소: flutter_secure_storage (토큰, 민감 정보)
- HTTP 통신: Dio

## 폴더 구조
```
lib/
├── main.dart
├── app.dart
├── models/           # [M] 데이터 모델
├── views/            # [V] 화면 UI
│   ├── screens/
│   └── widgets/
├── controllers/      # [C] 컨트롤러 (Provider)
├── services/         # API 통신
├── core/             # 공통 유틸 (constants, theme, utils, extensions)
├── config/           # 설정 파일
└── router/           # 라우팅 (go_router)
```

## MVC 역할 정의
| 구분 | 폴더 | 역할 |
|------|------|------|
| Model | models/ | 데이터 구조 정의, JSON 변환 |
| View | views/ | UI 렌더링, 사용자 인터페이스 |
| Controller | controllers/ | 비즈니스 로직, 상태 관리, View-Model 연결 |

## config/ 폴더 구조
| 파일 | 역할 |
|------|------|
| dio_config.dart | Dio 인스턴스 생성, Interceptor 설정, 타임아웃 설정 |
| secure_storage.dart | flutter_secure_storage 래퍼 클래스 (토큰, 민감 정보 저장) |
| preferences.dart | SharedPreferences 래퍼 클래스 (일반 설정값 저장) |

## core/ 폴더 구조
| 폴더 | 역할 |
|------|------|
| constants/ | 상수 정의 (API URL, 앱 설정값, 에러 메시지 등) |
| theme/ | 앱 테마, 색상(AppColors), 텍스트 스타일(AppTextStyles) |
| utils/ | 공통 유틸 함수 (날짜 포맷, 유효성 검사, 에러 처리 등) |
| extensions/ | Dart 확장 메서드 (String, DateTime 등) |

## 마이그레이션 진행 순서
1. 공통 기반 구축 (core, config, router)
2. 공통 위젯 구현 (views/widgets)
3. Model 정의 (models)
4. Service 구현 (services)
5. 의존성 적은 화면부터 View + Controller 구현
6. 핵심 기능 화면 구현

## 주의사항
- **코드 작성 / 수정 시마다 `docs/` 폴더의 관련 규칙 문서를 먼저 확인** 후 진행한다
- View에서 직접 API 호출 금지, Controller를 통해 호출한다
- Controller에서 UI 코드 금지, 상태와 로직만 처리한다
- 민감 정보는 반드시 flutter_secure_storage를 사용한다
- 각 화면 완성 후 다음 화면으로 이동한다 (View + Controller + 테스트)

## 작업 이력 기록
- 모든 작업 이력은 프로젝트 루트의 `history.md` 에 기록한다 (이전 이름: `log.md`).
- 새 기능 구현 / 버그 수정 / 패키지 변경 시 `history.md` 의 갱신 이력 표에 한 줄 이상 추가한다.
- `history.md` 는 작업 진행 상황 파악용 단일 출처 (single source of truth) 이다.
