import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/todo.dart';
import 'provider/todo_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TodoProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  // const MainPage({Key key}) : super(key: key);
  final TextEditingController controllerAddTask = TextEditingController();
  final TextEditingController controllerSearch = TextEditingController();
  final Color addTaskColor = Colors.black;
  final Color searchColor = Colors.indigo;
  final Color topLineColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, todoProvider, child) {
      return Scaffold(
          backgroundColor:
              todoProvider.isAddTaskView() ? addTaskColor : searchColor,
          appBar: EmptyAppBar(),
          body: Consumer<TodoProvider>(builder: (context, todoProvider, child) {
            return Column(
              children: [
                if (todoProvider.isAddTaskView()) getAddTaskForm(todoProvider),
                if (todoProvider.isSearchView()) getSearchForm(todoProvider),
                getTabLine(todoProvider),
                getListHeadLine(todoProvider),
                if (todoProvider.isAddTaskView()) getFullList(todoProvider),
                if (todoProvider.isSearchView())
                  getDoneList(context, todoProvider),
              ],
            );
          }));
    });
  }

  Widget getDoneList(BuildContext context, TodoProvider todoProvider) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: ListView(
            key: const PageStorageKey<String>('DoneList'),
            children: todoProvider
                .getDoneTodosByFilter()
                .map((x) => ListTile(
                    onTap: () {
                      delClick(context, todoProvider, x.id);
                    },
                    title: Text(x.title)))
                .toList()),
      ),
    );
  }

  void delClick(BuildContext context, TodoProvider todoProvider, UniqueKey id) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        todoProvider.delete(id);
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Delete record"),
      content: Text("Would you like to delete this record?"),
      actions: [
        cancelButton,
        yesButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget getFullList(TodoProvider todoProvider) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: ListView(
            key: const PageStorageKey<String>('FullList'),
            children: todoProvider
                .getAllTodos()
                .map((x) => CheckboxListTile(
                    value: x.isDone,
                    onChanged: (v) {
                      todoProvider.done(x.id);
                    },
                    title: Text(x.title)))
                .toList()),
      ),
    );
  }

  Widget getAddTaskForm(TodoProvider todoProvider) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              controller: controllerAddTask,
              decoration: InputDecoration(
                  labelText: 'Добавить задачу',
                  labelStyle: TextStyle(color: Colors.white30),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  )),
            ),
          ),
          RaisedButton(
              child: Text('Добавить'),
              onPressed: () {
                todoProvider.add(Todo(
                    id: UniqueKey(),
                    isDone: false,
                    title: controllerAddTask.text));
                controllerAddTask.clear();
              }),
        ],
      ),
    );
  }

  Widget getSearchForm(TodoProvider todoProvider) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        controller: controllerSearch,
        onChanged: (text) {
          todoProvider.setDoneTodosFilter(text);
        },
        decoration: InputDecoration(
          labelText: 'Поиск',
          suffixIcon: IconButton(
            onPressed: () =>
                todoProvider.setDoneTodosFilter(controllerSearch.text),
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  Widget getTabLine(TodoProvider todoProvider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            child: Text('Список задач',
                style: TextStyle(
                    color: todoProvider.isAddTaskView()
                        ? Colors.white
                        : Colors.white30)),
            onTap: () {
              todoProvider.setAddTaskView();
            },
          ),
          GestureDetector(
            child: Text('Выполненные',
                style: TextStyle(
                    color: todoProvider.isSearchView()
                        ? Colors.white
                        : Colors.white30)),
            onTap: () {
              todoProvider.setSearchTaskView();
            },
          ),
        ],
      ),
    );
  }

  Widget getListHeadLine(TodoProvider todoProvider) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 5,
            color: todoProvider.isAddTaskView() ? topLineColor : searchColor,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 5,
            color: todoProvider.isSearchView() ? topLineColor : addTaskColor,
          ),
        ),
      ],
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}
