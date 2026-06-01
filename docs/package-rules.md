# 패키지 사용 규칙

## SharedPreferences 규칙
- 유출되어도 위험하지 않은 일반 데이터에만 사용한다
- 사용 대상: 앱 설정값, 캐시 데이터, 온보딩 완료 여부 등
- config/preferences.dart 래퍼 클래스를 통해 접근한다
- 직접 SharedPreferences 인스턴스를 호출하지 않는다

## flutter_secure_storage 규칙
- 토큰, 비밀번호 등 민감한 정보에만 사용한다
- 사용 대상: access_token, refresh_token, 사용자 인증 정보
- config/secure_storage.dart 래퍼 클래스를 통해 접근한다
- 직접 FlutterSecureStorage 인스턴스를 호출하지 않는다
- 로그아웃 시 저장된 모든 민감 정보를 삭제한다

## Dio 규칙
- config/dio_config.dart에서 단일 인스턴스로 관리한다
- 인터셉터에서 토큰 자동 주입을 처리한다
- 401 에러 발생 시 토큰 갱신 로직을 인터셉터에서 처리한다
- 타임아웃 설정을 반드시 지정한다 (연결 10초, 수신 10초 권장)
- Service 계층에서만 Dio를 사용하고, Controller나 View에서 직접 호출하지 않는다

## 환경 변수 관리 (dotenv)
- API URL, 앱 bundle id 등 유출되면 안 되는 정보는 .env 파일에 저장한다
- .env 파일은 반드시 .gitignore에 추가하여 git에 올라가지 않도록 한다
- .env.example 파일을 만들어 필요한 키 목록을 공유한다 (값은 비워둠)

## 보안 관련 금지사항
- API 키, 시크릿을 코드에 하드코딩하지 않는다
- 토큰이나 비밀번호를 로그에 출력하지 않는다
- 릴리즈 빌드에서 상세 에러 정보를 노출하지 않는다
- 민감 정보를 SharedPreferences에 저장하지 않는다
