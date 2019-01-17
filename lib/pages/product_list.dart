import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/scoped-models/products.dart';

import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function updateProduct;
  final Function deleteProduct;
  final List<Product> products;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget widget, ProductsModel model) {
        return IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.red,
          ),
          onPressed: () {
            model.selectProduct(index);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductEditPage();
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index].title),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection value) {
            if (value == DismissDirection.endToStart) {
              deleteProduct(index);
            }
          },
          background: Container(
            color: Colors.red,
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10.0),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      products[index].imageUrl,
                    ),
                  ),
                  title: Text(products[index].title),
                  // contentPadding: EdgeInsets.all(100),
                  subtitle: Text('\$${products[index].price.toString()}'),
                  trailing: _buildEditButton(context, index)),
              Divider()
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
