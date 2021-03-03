import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'views/profile_view.dart';
import 'views/todo_view.dart';

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
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => LoginView(),
        '/profile': (context) => ProfileView(),
        '/todo': (context) => TodoView(),
      },
    );
  }
}
