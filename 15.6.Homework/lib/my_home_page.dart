import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_app_156/general_repo.dart';

import 'main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  String _catFact = '';

  GeneralRepo get repository => getIt<GeneralRepo>();

  @override
  void initState() {
    super.initState();
    fetchFact();
  }

  Future<void> fetchFact() async {
    setState(() {
      _isLoading = true;
    });

    final fact = await repository.fetchCatFact();

    setState(() {
      _catFact = fact;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _isLoading ? CircularProgressIndicator() : showDataWidget(),
      ),
    );
  }

  Widget showDataWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(_catFact ?? 'Ошибка получения данных'),
        ),
        if (!kReleaseMode) Text(repository.repoName),
        RaisedButton(child: Text(_catFact == null ? 'Try again' : 'Show a new one'), onPressed: fetchFact),
      ],
    );
  }
}
