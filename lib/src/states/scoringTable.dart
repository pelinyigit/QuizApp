import 'question.dart';

class TriviaStats {
  TriviaStats() {
    corrects = [];
    wrongs = [];
    score = 0;
  }

  List<Question> corrects;
  List<Question> wrongs;
  List<Question> noAnswered;
  int score;

  void addCorrect(Question question) {
    corrects.add(question);
    score += 10;
  }

  void addWrong(Question question) {
    wrongs.add(question);
    score -= 10;
  }

  void reset() {
    corrects = [];
    wrongs = [];
    score = 0;
  }
}
