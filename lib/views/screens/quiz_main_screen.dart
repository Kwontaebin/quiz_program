import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../controllers/quiz_controller.dart';
import '../../models/quiz_model.dart';
import '../../router/router.dart';
import '../widgets/video_player_widget.dart';

enum QuizState { intro, question, correct, wrong }

class QuizMainScreen extends StatefulWidget {
  const QuizMainScreen({super.key});

  @override
  State<QuizMainScreen> createState() => _QuizMainScreenState();
}

class _QuizMainScreenState extends State<QuizMainScreen> {
  QuizState _currentState = QuizState.intro;
  late String _quizNum;
  late final QuizData _quiz;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _lastSelection = 0; // 사용자가 마지막으로 선택한 번호 저장
  int? _tappedSelection; // 터치된 번호 저장 (개별 반짝임 효과용)
  bool _showExplanation = false; // 힌트 표시 여부 플래그

  @override
  void initState() {
    super.initState();
    final controller = context.read<QuizController>();
    final qNum = controller.quizNum;

    if (qNum == null) {
      // quizNum이 없으면 즉시 선택 화면으로 이동
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(AppRouter.selection);
      });
    } else {
      // 있을 때만 정상적으로 데이터 로드
      _quizNum = qNum;
      final quizMap = QuizRepository.getQuizMap();
      final quizList = quizMap[_quizNum] ?? quizMap['1']!;
      _quiz = quizList[0];
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _onVideoEnded() {
    if (!mounted) return;
    setState(() {
      _showExplanation = false; // 상태 변경 시 힌트 플래그 초기화
      switch (_currentState) {
        case QuizState.intro:
          _currentState = QuizState.question;
          break;
        case QuizState.correct:
          context.read<QuizController>().clearWrongAnswers();
          context.go(AppRouter.splash);
          break;
        case QuizState.wrong:
          // 오답 영상이 끝나고 화면으로 돌아올 때 취소선 적용을 위해 컨트롤러에 저장
          context.read<QuizController>().addWrongAnswer(_lastSelection);
          _currentState = QuizState.question;
          break;
        default:
          break;
      }
    });
  }

  void _handleSkip() {
    if (_currentState == QuizState.wrong && _showExplanation) {
      _onVideoEnded();
    }
  }

  void _handleAnswer(int selection) async {
    _lastSelection = selection;
    final isCorrect = selection == _quiz.correctAnswer;

    try {
      // 1. 상태 초기화를 위해 먼저 정지
      await _audioPlayer.stop();

      // 2. 재생 시작과 함께 [완료 이벤트 vs 400ms 타이머] 중 먼저 끝나는 쪽 대기
      // 이를 통해 기기 지연에 상관없이 빠른 응답성(0.4초 내외) 확보
      await Future.wait([
        _audioPlayer.play(AssetSource('Audio/button.mp3')),
        Future.any([
          _audioPlayer.onPlayerComplete.first,
          Future.delayed(const Duration(milliseconds: 400)),
        ]),
      ]);
    } catch (e) {
      debugPrint('Audio hybrid performance error: $e');
    }

    if (!mounted) return;

    // 3. 소리가 끝나자마자 즉시 상태 변경하여 영상/이미지 노출
    setState(() {
      _currentState = isCorrect ? QuizState.correct : QuizState.wrong;
    });

    // 오답일 경우 설명 텍스트 타이밍 조정
    if (!isCorrect) {
      // 영상 시작 시점에 맞춰 3초 후 표시
      Future.delayed(const Duration(milliseconds: 3000), () {
        if (mounted && _currentState == QuizState.wrong) {
          setState(() {
            _showExplanation = true;
          });
        }
      });
      Future.delayed(const Duration(milliseconds: 7000), () {
        if (mounted && _currentState == QuizState.wrong) {
          setState(() {
            _showExplanation = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // quizNum이 아직 없는 상태라면 빈 화면만 반환 (곧 initState에 의해 이동됨)
    final qNum = context.watch<QuizController>().quizNum;
    if (qNum == null) {
      return const Scaffold(backgroundColor: Colors.black);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(child: _buildContent()),
    );
  }

  String _getVideoPath(String type) {
    final String basePath = 'assets/$_quizNum/';
    if (type == 'intro') {
      return '$basePath${_quizNum}_1.mp4';
    }
    // 모든 프로젝트 공통 규칙 적용 (o_1, x_1)
    if (type == 'correct') {
      return '$basePath${_quizNum}_o_1.mp4';
    } else {
      return '$basePath${_quizNum}_x_1.mp4';
    }
  }

  Widget _buildContent() {
    switch (_currentState) {
      case QuizState.intro:
        return GestureDetector(
          onTap: _handleSkip,
          behavior: HitTestBehavior.opaque,
          child: VideoPlayerWidget(
            key: ValueKey('intro_$_quizNum'),
            assetPath: _getVideoPath('intro'),
            onEnded: _onVideoEnded,
          ),
        );
      case QuizState.question:
        return _buildQuestionUI();
      case QuizState.correct:
      case QuizState.wrong:
        final imagePath = 'assets/$_quizNum/$_quizNum문제2.jpg';
        return GestureDetector(
          onTap: _handleSkip,
          behavior: HitTestBehavior.opaque,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(imagePath, fit: BoxFit.cover),
              VideoPlayerWidget(
                key: ValueKey('${_currentState.name}_$_quizNum'),
                assetPath: _getVideoPath(_currentState.name),
                onEnded: _onVideoEnded,
              ),
              // 오답 시 4초 후에 두루마리 위치에 설명 텍스트 표시
              if (_currentState == QuizState.wrong)
                Center(
                  child: IgnorePointer(
                    child: AnimatedOpacity(
                      opacity: _showExplanation ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        width: 400.w,
                        padding: EdgeInsets.only(top: 20.h),
                        child: Text(
                          _quiz.explanations[_lastSelection - 1],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.sp,
                            // fontFamily: 'HakgyoansimTuho',
                            fontFamily: 'MaruBuri',
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
    }
  }

  Widget _buildQuestionUI() {
    final controller = context.watch<QuizController>();
    final imagePath = 'assets/$_quizNum/$_quizNum문제2.jpg';
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(imagePath, fit: BoxFit.cover),
        Positioned(
          top: 455.h,
          left: 300.w,
          right: 300.w,
          child: Column(
            children: [
              _buildAnswerBox(controller, 1),
              SizedBox(height: 53.h),
              _buildAnswerBox(controller, 2),
              SizedBox(height: 53.h),
              _buildAnswerBox(controller, 3),
              SizedBox(height: 53.h),
              _buildAnswerBox(controller, 4),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerBox(QuizController controller, int selection) {
    final isWrong = controller.wrongAnswerIndices.contains(selection);
    return SizedBox(
      height: 75.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                debugPrint('$selection번 터치');
                _handleAnswer(selection);
              },
              splashColor: Colors.black.withOpacity(0.15),
              highlightColor: Colors.black.withOpacity(0.05),
              child: const SizedBox.expand(),
            ),
          ),
          if (isWrong)
            IgnorePointer(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 3.h,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
