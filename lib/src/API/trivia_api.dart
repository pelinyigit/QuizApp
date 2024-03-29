import 'dart:async';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'package:frideos_core/frideos_core.dart';

import '../states/category.dart';
import '../states/question.dart';

import 'api_interface.dart';

class TriviaAPI implements QuestionsAPI {
  @override
  Future<bool> getCategories(StreamedList<Category> categories) async {
    const categoriesURL = 'https://opentdb.com/api_category.php';
    final response = await http.get(categoriesURL);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final result = (jsonResponse['trivia_categories'] as List)
          .map((category) => Category.fromJson(category));

      categories.value = [];
      categories
        ..addAll(result)
        ..addElement(Category(id: 0, name: 'Any category'));
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  @override
  Future<bool> getQuestions(
      {StreamedList<Question> questions,
      int number,
      Category category,
      QuestionDifficulty difficulty,
      QuestionType type}) async {

    var qtype;
 

    switch (type) {
      default:
        qtype = 'boolean';
        break;
    }

    final url =
        'https://opentdb.com/api.php?amount=$number&type=$qtype&category=${category.id}';

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final result = (jsonResponse['results'] as List)
          .map((question) => QuestionModel.fromJson(question));

      questions.value = result
          .map((question) => Question.fromQuestionModel(question))
          .toList();

      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }
}
