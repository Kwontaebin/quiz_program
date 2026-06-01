import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/quiz_controller.dart';
import '../../router/router.dart';

class QuizSelectionScreen extends StatelessWidget {
  const QuizSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Redundant check since router should handle, but user asked to check local storage
    final quizController = context.read<QuizController>();

    return Scaffold(
      body: Center(
        child: Container(
          width: 1920.w,
          height: 1080.h,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '프로젝트 선택',
                style: TextStyle(fontSize: 60.sp, fontFamily: "MaruBuri"),
              ),
              SizedBox(height: 50.h),
              SizedBox(
                width: 1300.w,
                height: 700.h,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 40.w,
                    mainAxisSpacing: 40.h,
                    childAspectRatio: 400 / 300,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final num = (index + 1).toString();
                    return GestureDetector(
                      onTap: () async {
                        await quizController.selectQuiz(num);
                        if (context.mounted) {
                          context.go(AppRouter.splash);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.blue, width: 2.w),
                        ),
                        child: Center(
                          child: Text(
                            num,
                            style: TextStyle(
                              fontSize: 80.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
