import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';
import '../states/appstate.dart';
import '../states/category.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    return Material(
      child: FadeInWidget(
        duration: 750,
        child: Container(
          color: Colors.blueGrey,
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: ValueBuilder<List<Category>>(
            streamed: appState.categoriesStream,
            noDataChild: const CircularProgressIndicator(),
            builder: (context, snapshot) {
              final categories = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(25.0),
                            child: Text(
                              'QuizApp',
                              style: TextStyle(
                                fontSize: 46.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 4.0,
                              ),
                            ),
                          ),
                          const Text(
                            'Choose a category:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          ValueBuilder<Category>(
                            streamed: appState.categoryChosen,
                            builder: (context, snapshotCategory) =>
                                DropdownButton<Category>(
                                  isExpanded: true,
                                  value: snapshotCategory.data,
                                  onChanged: appState.setCategory,
                                  items: categories
                                      .map<DropdownMenuItem<Category>>(
                                        (value) => DropdownMenuItem<Category>(
                                              value: value,
                                              child: Text(
                                                value.name,
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                      )
                                      .toList(),
                                ),
                          ),
                          const Text(
                            'Start!',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          ),
                          
                        ],
                      ),
                    ),
                    onTap: appState.startTrivia,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
