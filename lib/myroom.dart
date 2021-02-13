import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyroomPage extends StatefulWidget {
  MyroomPage(this._userName);

  final String _userName;

  @override
  _MyroomPageState createState() => new _MyroomPageState();
}

class _MyroomPageState extends State<MyroomPage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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

  Widget _ownMessage(String message, String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(userName),
            Text(message),
          ],
        ),
        Icon(Icons.person),
      ],
    );
  }

  Widget _message(String message, String userName) {
    return Row(
      children: <Widget>[
        Icon(Icons.person),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(userName),
            Text(message),
          ],
        )
      ],
    );
  }

  _handleSubmit(String message) {
    _controller.text = "";
    var db = FirebaseFirestore.instance;
    db.collection("chat_room").add({
      "user_name": widget._userName,
      "message": message,
      "created_at": DateTime.now()
    }).then((val) {
      print("成功です");
    }).catchError((err) {
      print(err);
    });
  }
}
