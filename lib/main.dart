import 'package:flutter/material.dart';
import 'package:udemy_course/pages/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,

      ),
      home: AuthPage()
      //MyHomePage(title: 'Udemy Courses'),
    );
  }
}


