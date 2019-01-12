import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/widgets/products/products.dart';

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
              leading: Icon(Icons.edit),
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite,),
              onPressed: () {},
            )
          ],
        ),
        body: Products(products));
  }
}
