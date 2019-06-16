import 'package:frideos_core/frideos_core.dart';

import '../states/category.dart';
import '../states/question.dart';

abstract class QuestionsAPI {
  Future<bool> getCategories(StreamedList<Category> categories);
  Future<bool> getQuestions(
      {StreamedList<Question> questions,
      int number,
      Category category,
      QuestionType type});
}
