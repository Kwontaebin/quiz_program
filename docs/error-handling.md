# 에러 처리 규칙

## Null 처리 규칙
- 모든 변수는 nullable 여부를 명확히 선언한다 (String? vs String)
- API 응답 데이터는 null 가능성을 항상 고려하여 처리한다
- null 체크 시 if문 또는 null-aware 연산자(?., ??, ??=)를 적절히 사용한다
- Model의 fromJson에서 서버 응답이 null일 경우 기본값을 지정한다
- 리스트는 null 대신 빈 리스트([])로 초기화하여 null 체크를 줄인다
- late 키워드는 확실히 초기화되는 경우에만 사용하고, 불확실하면 nullable로 선언한다

## 예외 처리 규칙
- Interceptor에서 처리되지 않는 에러(파싱, 비즈니스 로직)는 try-catch로 처리한다
- Controller에서 에러 발생 시 errorMessage 상태를 업데이트하여 View에 전달한다
- 에러 발생 시에도 앱이 크래시되지 않도록 방어적으로 코딩한다
- 공통 에러 처리 로직은 core/utils/에 유틸로 분리하여 재사용한다
- 무한 반복에 빠지지 않도록 모든 분기에서 return 처리를 철저하게 한다

## 에러 메시지 규칙
- 네트워크 에러와 서버 에러를 구분하여 사용자에게 적절한 메시지를 보여준다
- 디버그 모드에서만 상세 에러 로그를 출력한다
- 릴리즈 모드에서는 사용자 친화적인 간략한 메시지만 표시한다
- 에러 메시지는 사용자가 다음 행동을 알 수 있도록 안내를 포함한다

## 로딩 및 에러 상태 처리
- Controller에 isLoading, errorMessage 상태를 포함한다
- API 호출 시작 시 isLoading을 true로, 완료 시 false로 변경한다
- 에러 발생 시 errorMessage를 설정하고, 성공 시 null로 초기화한다
- View에서 isLoading, errorMessage 상태에 따라 적절한 UI를 표시한다

## Dio Interceptor를 통한 에러 일괄 처리
- Dio의 Interceptor를 사용하면 모든 API 요청의 에러를 한 곳에서 일괄 처리할 수 있다
- config/dio_config.dart에 ErrorInterceptor를 등록하여 공통 에러 처리 로직을 구현한다
- 개별 Service나 Controller에서 중복으로 에러 처리 코드를 작성하지 않아도 된다

### Interceptor 에러 처리 역할
- 401 Unauthorized: 토큰 만료 시 자동으로 토큰 갱신을 시도하거나 로그인 화면으로 이동한다
- 403 Forbidden: 권한 없음 메시지를 표시한다
- 404 Not Found: 요청한 리소스가 없음을 알린다
- 500 Server Error: 서버 오류 메시지를 표시하고 재시도 안내를 한다
- Timeout: 연결 시간 초과 메시지를 표시한다
- No Internet: 네트워크 연결 상태를 확인하라는 메시지를 표시한다

### Interceptor 사용 시 주의사항
- Interceptor에서 처리한 에러도 필요 시 Controller로 전달하여 UI 상태를 업데이트한다
- 특정 API에서만 다르게 처리해야 하는 에러는 해당 Service에서 개별 처리한다
- Interceptor에서 에러를 완전히 삼키지 않고, 필요한 경우 재throw하여 호출부에서도 인지할 수 있게 한다
