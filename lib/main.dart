import 'package:flutter/material.dart';
import 'myroom.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primaryColor: Colors.white),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if(_error) {
    //   return SomethingWentWrong();
    // }
    //
    // // Show a loader until FlutterFire is initialized
    // if (!_initialized) {
    //   return Loading();
    // }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ユーザー名入力画面"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'ユーザー名'),
            ),
          ),
          RaisedButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => MyroomPage(_controller.text)));
            },
            child: Text(
              "設定完了",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
