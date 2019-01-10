import 'package:flutter/material.dart';
import 'package:udemy_course/pages/product_admin.dart';
import 'package:udemy_course/pages/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
  
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      // home: AuthPage(),

      routes: {
        '/': (context) => ProductsPage(),
        '/admin': (context) => ProductAdminPage()
      },
    );
  }
}
