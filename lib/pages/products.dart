import 'package:flutter/material.dart';
import 'package:udemy_course/pages/manage_product.dart';
import 'package:udemy_course/product_manager.dart';

class ProductsPage extends StatelessWidget {
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ManageProduct()));
              },
            )
          ],
        )),
        appBar: AppBar(
          title: Text('Product list'),
        ),
        body: ProductManager());
  }
}
