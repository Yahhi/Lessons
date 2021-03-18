import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'local_repo.dart';
import 'server_repo.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<LocalRepo>(LocalRepo(), signalsReady: true);
  getIt.registerSingleton<ServerRepo>(ServerRepo(), signalsReady: true);
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
      _isServerError = false;
    });

    var serverCatFact = await getIt<ServerRepo>().fetchStringFromCatFact();

    if (serverCatFact != null) {
      setState(() {
        _catFact = serverCatFact;
        _repoName = 'Server repo';
      });

      //save to local repo.
      getIt<LocalRepo>().addString(serverCatFact);
    } else {
      setState(() {
        _isServerError = true;
      });

      //get from local repo.
      var anyString = getIt<LocalRepo>().getAnyString();

      if (anyString != null)
        setState(() {
          _catFact = anyString;
          _repoName = 'Local repo';
        });
    }

    if (_catFact == null) {
      setState(() {
        _repoName = 'Error of data loading';
      });
    }

    setState(() {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isLoading) CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_catFact),
            ),
            Text(_repoName),
            RaisedButton(
                child: Text(_isServerError ? 'Try again' : 'Show a new one'),
                onPressed: () {
                  getData();
                }),
          ],
        ),
      ),
    );
  }
}
