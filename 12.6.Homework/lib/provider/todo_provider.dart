import 'package:flutter/material.dart';
import 'package:test_app_126/model/todo.dart';

enum ViewState { addTask, search }

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = List<Todo>();
  ViewState _viewState = ViewState.addTask;
  String _doneTodosFilter = '';

  void setAddTaskView() {
    _viewState = ViewState.addTask;
    notifyListeners();
  }

  void setSearchTaskView() {
    _viewState = ViewState.search;
    notifyListeners();
  }

  bool isAddTaskView() {
    return _viewState == ViewState.addTask;
  }

  bool isSearchView() {
    return _viewState == ViewState.search;
  }

  void add(Todo newTodo) {
    if (newTodo.title == null || newTodo.title == '') return;

    _todos.add(newTodo);
    print('add Todo ${newTodo.title}');
    notifyListeners();
  }

  void done(UniqueKey id) {
    Todo todo = _todos.firstWhere((x) => x.id == id);
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void delete(UniqueKey id) {
    _todos.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  List<Todo> getAllTodos() {
    return _todos;
  }

  List<Todo> getDoneTodos() {
    return _todos.where((x) => x.isDone).toList();
  }

  void setDoneTodosFilter(String text) {
    _doneTodosFilter = text;
    notifyListeners();
  }

  List<Todo> getDoneTodosByFilter() {
    var resultWithNoFilter = _todos.where((x) => x.isDone);
    var resultWithFilter = _todos.where((x) => x.isDone && x.title.contains(_doneTodosFilter));
    return _doneTodosFilter == '' ? resultWithNoFilter.toList() : resultWithFilter.toList();
  }
}
