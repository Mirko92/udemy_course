import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/pages/auth.dart';
import 'package:udemy_course/pages/product.dart';
import 'package:udemy_course/pages/product_admin.dart';
import 'package:udemy_course/pages/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Product> _products = [];

  void _addProduct(Product product) {
    setState(() {
      _products.add(product);
    });
    print(_products);
  }

  void _updateProduct(int index, Product updateProduct) {
    setState(() {
      _products[index] = updateProduct;
    });
    print(_products);
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
        buttonColor: Colors.deepPurple,
      ),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/products': (BuildContext context) => ProductsPage(_products),
        '/admin': (BuildContext context) =>
            ProductsAdminPage(_addProduct, _updateProduct, _deleteProduct, _products ),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(_products[index]),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(_products));
      },
    );
  }
}
