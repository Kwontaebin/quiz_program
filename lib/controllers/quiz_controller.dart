import 'package:flutter/material.dart';
import '../config/preferences.dart';

class QuizController extends ChangeNotifier {
  String? _quizNum;
  bool _isLoading = false;
  final List<int> _wrongAnswerIndices = [];

  String? get quizNum => _quizNum;
  bool get isLoading => _isLoading;
  List<int> get wrongAnswerIndices => List.unmodifiable(_wrongAnswerIndices);

  QuizController() {
    _quizNum = Preferences.quizNum;
  }

  Future<void> selectQuiz(String num) async {
    _isLoading = true;
    notifyListeners();

    await Preferences.setQuizNum(num);
    _quizNum = num;
    _wrongAnswerIndices.clear();

    _isLoading = false;
    notifyListeners();
  }

  void addWrongAnswer(int index) {
    if (!_wrongAnswerIndices.contains(index)) {
      _wrongAnswerIndices.add(index);
      notifyListeners();
    }
  }

  void clearWrongAnswers() {
    _wrongAnswerIndices.clear();
    notifyListeners();
  }
}
