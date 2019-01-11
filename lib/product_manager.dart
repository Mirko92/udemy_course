import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';

import './products.dart';

class ProductManager extends StatelessWidget {
  final List<Product> products;

  ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Column(
      children: [Expanded(child: Products(products))],
    );
  }
}