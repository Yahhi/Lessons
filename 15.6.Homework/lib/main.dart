import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'general_repo.dart';
import 'local_repo.dart';
import 'my_home_page.dart';
import 'server_repo.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<GeneralRepo>(ServerRepo());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  StreamSubscription subscription;

  @override
  void initState() {
    _checkCurrentConnectivity();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      changeRepository(connectivityResult);
    });
    super.initState();
  }

  Future<void> _checkCurrentConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    changeRepository(connectivityResult);
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  void changeRepository(ConnectivityResult connectivityResult) async {
    print(connectivityResult);
    getIt.unregister<GeneralRepo>();
    if (connectivityResult == ConnectivityResult.none) {
      getIt.registerSingleton<GeneralRepo>(LocalRepo());
    } else {
      getIt.registerSingleton<GeneralRepo>(ServerRepo());
    }
  }

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
