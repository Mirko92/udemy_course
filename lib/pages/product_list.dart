import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  ProductListPage(this.products);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.asset(products[index].imageUrl),
          title: Text(products[index].title),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProductEditPage(product: products[index]);
                  },
                ),
              );
            },
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
