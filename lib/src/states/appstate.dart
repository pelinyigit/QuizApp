import 'dart:async';

import 'package:flutter/material.dart';

import 'package:frideos_core/frideos_core.dart';

import 'package:frideos/frideos.dart';

import '../API/api_interface.dart';
import '../API/trivia_api.dart';
import '../blocs/trivia_bloc.dart';
import '../states/category.dart';
import '../states/models.dart';
import '../states/question.dart';

class AppState extends AppStateModel {
  factory AppState() => _singletonAppState;

  AppState._internal() {
    print('-------APP STATE INIT--------');
    _loadCategories();

    countdown.value = 10.toString();
    countdown.setTransformer(validateCountdown);

    questionsAmount.value = 5.toString();
    questionsAmount.setTransformer(validateAmount);

    triviaBloc = TriviaBloc(
        countdownStream: countdown,
        questions: questions,
        tabController: tabController);
  }

  static final AppState _singletonAppState = AppState._internal();


  // API
  QuestionsAPI api = TriviaAPI();
  final apiType = StreamedValue<ApiType>(initialData: ApiType.remote);
  

  // TABS
  final tabController = StreamedValue<AppTab>(initialData: AppTab.main);

  // TRIVIA
  final categoriesStream = StreamedList<Category>();
  final categoryChosen = StreamedValue<Category>();
  final questions = StreamedList<Question>();
  final questionsDifficulty =
      StreamedValue<QuestionDifficulty>(initialData: QuestionDifficulty.medium);

  final questionsAmount = StreamedTransformed<String, String>();

  final validateAmount =
      StreamTransformer<String, String>.fromHandlers(handleData: (str, sink) {
    if (str.isNotEmpty) {
      final amount = int.tryParse(str);
      if (amount > 1 && amount <= 15) {
        sink.add(str);
      } else {
        sink.addError('Insert a value from 2 to 15..');
      }
    } else {
      sink.addError('Insert a value.');
    }
  });

  // BLOC
  TriviaBloc triviaBloc;

  // COUNTDOWN
  final countdown = StreamedTransformed<String, String>();

  final validateCountdown =
      StreamTransformer<String, String>.fromHandlers(handleData: (str, sink) {
    if (str.isNotEmpty) {
      final time = int.tryParse(str);
      if (time >= 3 && time <= 90) {
        sink.add(str);
      } else {
        sink.addError('Insert a value from 3 to 90 seconds.');
      }
    } else {
      sink.addError('Insert a value.');
    }
  });

  @override
  Future<void> init() async {
   
  }

  Future _loadCategories() async {
    final isLoaded = await api.getCategories(categoriesStream);
    if (isLoaded) {
      categoryChosen.value = categoriesStream.value.last;
    }
  }

  Future _loadQuestions() async {
    await api.getQuestions(
        questions: questions,
        number: int.parse(questionsAmount.value),
        category: categoryChosen.value,
        type: QuestionType.multiple);
  }

  void setCategory(Category category) => categoryChosen.value = category;

  void setDifficulty(QuestionDifficulty difficulty) =>
      questionsDifficulty.value = difficulty;

  void setApiType(ApiType type) {
    if (apiType.value != type) {
      apiType.value = type;
      if (type == ApiType.remote) {
           api = TriviaAPI(); 
      }
      _loadCategories();
    }
  }



  set _changeTab(AppTab appTab) => tabController.value = appTab;

  void startTrivia() {
    _loadQuestions();
    _changeTab = AppTab.trivia;
  }

  void endTrivia() => tabController.value = AppTab.main;

  void showSummary() => tabController.value = AppTab.summary;

  @override
  void dispose() {
    print('---------APP STATE DISPOSE-----------');
    apiType.dispose();
    categoryChosen.dispose();
    countdown.dispose();
    questions.dispose();
    questionsAmount.dispose();
    questionsDifficulty.dispose();
    tabController.dispose();
    triviaBloc.dispose();
  }
}
