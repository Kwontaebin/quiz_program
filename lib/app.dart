import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'controllers/quiz_controller.dart';
import 'router/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final QuizController _quizController;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _quizController = QuizController();
    _router = AppRouter.createRouter(_quizController);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: _quizController)],
      child: ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Focus(
            autofocus: true,
            onKeyEvent: (node, event) => KeyEventResult.handled, // 키보드 이벤트 소모
            child: MaterialApp.router(
              title: 'Quiz Program',
              routerConfig: _router,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
