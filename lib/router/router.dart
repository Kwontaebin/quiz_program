import 'package:go_router/go_router.dart';
import '../views/screens/splash_screen.dart';
import '../views/screens/quiz_selection_screen.dart';
import '../views/screens/quiz_main_screen.dart';
import '../controllers/quiz_controller.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String selection = '/';
  static const String main = '/main';

  static GoRouter createRouter(QuizController quizController) {
    return GoRouter(
      initialLocation: splash,
      redirect: (context, state) {
        // quizNum이 없으면 프로젝트 선택 화면으로 강제 이동
        final hasQuiz = quizController.quizNum != null;
        if (state.matchedLocation == splash && !hasQuiz) {
          return selection;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: selection,
          builder: (context, state) => const QuizSelectionScreen(),
        ),
        GoRoute(
          path: splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: main,
          builder: (context, state) => const QuizMainScreen(),
        ),
      ],
    );
  }
}
