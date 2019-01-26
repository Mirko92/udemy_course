   import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/pages/auth.dart';
import 'package:udemy_course/pages/product.dart';
import 'package:udemy_course/pages/product_admin.dart';
import 'package:udemy_course/pages/products.dart';
import 'package:udemy_course/scoped-models/main.dart';

void main() {
  MapView.setApiKey('AIzaSyDo9ANuxA9wGTY9PGwTd-s8nnQnEkuMCvQ');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _mainModel = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _mainModel.autoAuthenticate();

    _mainModel.user$.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _mainModel,
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
          buttonColor: Colors.deepPurple,
        ),
        routes: {
          '/': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductsPage(_mainModel),
          '/products': (BuildContext context) => 
              !_isAuthenticated ? AuthPage() : ProductsPage(_mainModel),
          '/admin': (BuildContext context) => 
              !_isAuthenticated ? AuthPage() : ProductsAdminPage(_mainModel),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated){
            return MaterialPageRoute<bool>(builder: (context) => AuthPage());
          }
          
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final String productId = pathElements[2];

            final Product product = _mainModel.allProducts
                .firstWhere((Product p) => p.id == productId);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => !_isAuthenticated ? AuthPage() : ProductPage(product),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => !_isAuthenticated ? AuthPage() : ProductsPage(_mainModel));
        },
      ),
    );
  }
}
