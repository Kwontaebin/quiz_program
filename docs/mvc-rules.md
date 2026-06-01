# MVC 규칙

## Model 규칙

### 역할
- 데이터 구조를 정의하는 클래스이다
- API 응답, 로컬 데이터 등 앱에서 사용하는 모든 데이터 형태를 정의한다
- models/ 폴더에 위치하며, *_model.dart로 명명한다

### 필수 구현
- fromJson: JSON 데이터를 Model 객체로 변환하는 factory 생성자
- toJson: Model 객체를 JSON으로 변환하는 메서드

### 권장 구현
- copyWith: 일부 필드만 변경한 새 객체를 생성하는 메서드
- toString: 디버깅을 위해 객체 정보를 문자열로 반환하는 메서드

### 필드 선언
- 모든 필드는 final로 선언하여 불변 객체로 만든다
- nullable 필드는 타입 뒤에 ?를 명시한다 (예: String? nickname)
- fromJson에서 null일 경우 기본값을 지정한다
- 리스트 필드는 null 대신 빈 리스트로 초기화한다

### 금지사항
- Model에 비즈니스 로직을 포함하지 않는다
- Model에서 API 호출을 하지 않는다

---

## View 규칙

### 역할
- 사용자에게 보여지는 UI를 담당한다
- views/screens/에 전체 화면, views/widgets/에 공통 위젯을 배치한다
- 화면 파일은 *_screen.dart, 위젯 파일은 *_widget.dart로 명명한다

### 작성 규칙
- View는 UI 렌더링만 담당하고 비즈니스 로직을 포함하지 않는다
- 재사용 가능한 위젯은 const 생성자를 적극 활용한다
- 공통 위젯은 views/widgets/에, 화면 전용 위젯은 해당 screen 폴더 내 widgets/에 배치한다

### 데이터 접근
- Controller의 데이터를 context.watch<T>() 또는 Consumer<T>로 구독한다
- 데이터 수정이 필요하면 Controller의 메서드를 호출한다
- View에서 직접 Model을 수정하지 않는다

### 금지사항
- View에서 직접 API를 호출하지 않는다
- View에서 직접 비즈니스 로직을 처리하지 않는다
- View에서 notifyListeners()를 호출하지 않는다

---

## Controller 규칙

### 역할
- 비즈니스 로직과 상태 관리를 담당한다
- View와 Model을 연결하는 중간 역할을 한다
- controllers/ 폴더에 위치하며, *_controller.dart로 명명한다

### 작성 규칙
- Controller는 ChangeNotifier를 상속한다
- 상태 변수는 private(_)으로 선언하고 getter로 외부에 노출한다
- 상태 변경 후에는 반드시 notifyListeners()를 호출한다
- isLoading, errorMessage 상태를 포함하여 로딩/에러 상태를 관리한다

### 등록 규칙
- 전역 데이터(사용자 정보, 장바구니 등)를 관리하는 Controller는 main.dart의 MultiProvider에 등록한다
- 특정 화면에서만 사용하는 Controller는 해당 화면에서 생성한다

### 금지사항
- Controller에서 UI 코드(위젯)를 작성하지 않는다
- Controller에서 BuildContext를 저장하거나 보관하지 않는다
- Controller 간 순환 참조를 만들지 않는다
- dispose() 시 리소스 정리를 누락하지 않는다

---

## Service 규칙

### 역할
- API 통신을 담당하는 계층이다
- Controller에서 호출하여 서버와 데이터를 주고받는다
- services/ 폴더에 위치하며, *_service.dart로 명명한다

### 작성 규칙
- Service는 API 통신만 담당하고 비즈니스 로직을 포함하지 않는다
- API 응답을 Model 객체로 변환하여 반환한다
- Dio 인스턴스는 직접 생성하지 않고 config/dio_config.dart에서 주입받는다

### 에러 처리
- 공통 에러는 Interceptor에서 처리한다
- Service에서는 필요한 경우에만 개별 에러 처리를 한다
- 에러 발생 시 적절한 예외를 throw하여 Controller에서 처리하도록 한다

### 금지사항
- Service에서 상태를 저장하지 않는다 (Controller 역할)
- Service에서 UI 관련 코드를 작성하지 않는다
- Service에서 직접 SharedPreferences나 SecureStorage에 접근하지 않는다
