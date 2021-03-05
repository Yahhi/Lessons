import 'package:flutter/material.dart';

class Todo {
  final UniqueKey id;
  String title;
  bool isDone;

  Todo({this.id, this.title, this.isDone});
}
