import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoView extends StatefulWidget {
  TodoView({Key key}) : super(key: key);

  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final GlobalKey<FormState> _form2Key = GlobalKey<FormState>();
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerDescr = TextEditingController();
  final dbRef = Firestore.instance;

  _saveTodo() async {
    var ref = await dbRef.collection('todos').add({
      'title': _controllerTitle.text,
      'descr': _controllerDescr.text,
      'isDone': false,
    });
    print(ref.documentID);
  }

  _submit() {
    if (_form2Key.currentState != null) {
      if (_form2Key.currentState.validate()) {
        _form2Key.currentState.save();
        _saveTodo();
        _form2Key.currentState.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('TodoView'),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 10),
          child: Form(
              key: _form2Key,
              child: Column(
                children: [
                  TextFormField(
                    key: Key('fieldTitle'),
                    controller: _controllerTitle,
                    validator: (value) {
                      if (value == '') return 'Enter title';
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Title new task'),
                  ),
                  TextFormField(
                    key: Key('fieldDescr'),
                    controller: _controllerDescr,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: _submit,
                    child: Text(
                      'Save new task',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )),
        ),
        Flexible(
          flex: 3,
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('todos').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();

              return _buildList(context, snapshot.data.documents);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = TodoModel.fromSnapshot(data);

    return Padding(
      key: ValueKey(data.documentID),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Column(
            children: [
              Text(
                record.title,
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
              Row(
                children: [
                  Text(record.descr),
                ],
              ),
            ],
          ),
          leading: GestureDetector(
            onTap: () {
              data.reference.updateData({'isDone': !record.isDone});
            },
            child: record.isDone
                ? Icon(
                    Icons.done,
                    size: 42,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.timer,
                    size: 42,
                    color: Colors.blue,
                  ),
          ),
          trailing: GestureDetector(
            onTap: () {
              Widget cancelButton = FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
              Widget yesButton = FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  data.reference.delete();
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
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

class TodoModel {
  final String documentID;
  final String title;
  final String descr;
  final bool isDone;

  TodoModel({this.title, this.descr, this.isDone, this.documentID});

  TodoModel.fromMap(Map<String, dynamic> map)
      : documentID = map['documentID'],
        title = map['title'],
        descr = map['descr'],
        isDone = map['isDone'];

  TodoModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);
}
