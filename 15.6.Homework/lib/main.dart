import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'general_repo.dart';
import 'local_repo.dart';
import 'server_repo.dart';
import 'package:connectivity/connectivity.dart';

GetIt getIt = GetIt.instance;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  bool _isServerError = false;
  String _repoName = '';
  String _catFact = '';

  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      reloadData(connectivityResult);
    });
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  void reloadData(ConnectivityResult connectivityResult) async {
    if (connectivityResult != ConnectivityResult.none) {
      await tryToReloadFromServer();
    } else {
      await getLocalData();
    }
  }

  Future tryToReloadFromServer() async {
    setState(() {
      _isLoading = true;
    });

    if ((await getServerData()) == null) {
      await getLocalData();
    }

    setState(() {
      _isLoading = false;
    });
  }

  getServerData() async {
    if (getIt.isRegistered<GeneralRepo>()) getIt.unregister<GeneralRepo>();
    getIt.registerSingleton<GeneralRepo>(ServerRepo(), signalsReady: true);
    var result = await getIt<GeneralRepo>().fetchCatFact();
    setState(() {
      _catFact = result;
      _isServerError = result == null;
      _repoName = 'Server data';
    });
    return result;
  }

  getLocalData() async {
    if (getIt.isRegistered<GeneralRepo>()) getIt.unregister<GeneralRepo>();
    getIt.registerSingleton<GeneralRepo>(LocalRepo(), signalsReady: true);
    var result = await getIt<GeneralRepo>().fetchCatFact();

    setState(() {
      _isLoading = false;
      _catFact = result;
      _repoName = 'Local data';
    });

    return result;
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
          child: Text('$_catFact'),
        ),
        if (!kReleaseMode) Text('$_repoName'),
        RaisedButton(
            child: Text(_isServerError ? 'Try again' : 'Show a new one'),
            onPressed: () {
              tryToReloadFromServer();
            }),
      ],
    );
  }
}
