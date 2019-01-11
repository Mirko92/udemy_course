import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/product_manager.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              title: Text('Manage Products'),
              onTap: () {
                print('[ProductsPage Drawer] onTap()');
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        )),
        appBar: AppBar(
          title: Text('Product list'),
        ),
        body: ProductManager(products));
  }
}
