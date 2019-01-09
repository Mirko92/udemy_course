import 'package:flutter/material.dart';
import 'package:udemy_course/pages/home.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: RaisedButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: 'Titolo',)));
            }),
      ),
    );
  }
}
