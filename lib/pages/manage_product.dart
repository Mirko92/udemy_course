import 'package:flutter/material.dart';
import 'package:udemy_course/pages/products.dart';

class ManageProduct extends StatelessWidget {
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
            title: Text('All Products'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductsPage()));
            },
          )
        ],
      )),
      appBar: AppBar(
        title: Text('Manage Product'),
      ),
      body: Center(child: Text('Temporaneo')),
    );
  }
}
