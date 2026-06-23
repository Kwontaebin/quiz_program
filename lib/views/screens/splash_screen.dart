import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../router/router.dart';
import '../widgets/video_player_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigateToNext(BuildContext context) {
    // 이제 스플래시는 프로젝트가 선택된 상태에서만 진입하므로, 항상 메인으로 이동합니다.
    context.go(AppRouter.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. 전체 화면 비디오 (반복 재생)
          const SizedBox.expand(
            child: VideoPlayerWidget(
              assetPath: 'assets/splash.mp4',
              isLooping: true,
            ),
          ),

          // 2. 특정 터치 영역 (두루마리 부분)
          // 스크린샷 가이드에 맞춰 가로 1100, 세로 480 정도로 조정
          Center(
            child: GestureDetector(
              onTap: () => _navigateToNext(context),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(width: 1100.w, height: 340.h),
            ),
          ),
        ],
      ),
    );
  }
}
