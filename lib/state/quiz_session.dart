import 'package:flutter/foundation.dart';
import '../models/question.dart';

class QuizSession extends ChangeNotifier {
  QuizSession({required this.questions});

  final List<QuizQuestion> questions;
  String playerName = '';
  int currentIndex = 0;
  final Map<int, int> answers = {};
  bool isFinished = false;

  QuizQuestion get currentQuestion => questions[currentIndex];
  int? get selectedAnswer => answers[currentIndex];
  int get answeredCount => answers.length;
  int get correctCount => answers.entries
      .where((entry) => questions[entry.key].correctIndex == entry.value)
      .length;
  double get percentage =>
      questions.isEmpty ? 0 : correctCount / questions.length * 100;
  bool get allAnswered => answers.length == questions.length;

  void start(String name) {
    playerName = name.trim();
    currentIndex = 0;
    answers.clear();
    isFinished = false;
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    if (isFinished) return;
    answers[currentIndex] = optionIndex;
    notifyListeners();
  }

  void goToQuestion(int index) {
    if (index < 0 || index >= questions.length) return;
    currentIndex = index;
    notifyListeners();
  }

  void next() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
      notifyListeners();
    }
  }

  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      notifyListeners();
    }
  }

  void finish() {
    isFinished = true;
    notifyListeners();
  }

  void reset() {
    playerName = '';
    currentIndex = 0;
    answers.clear();
    isFinished = false;
    notifyListeners();
  }
}
