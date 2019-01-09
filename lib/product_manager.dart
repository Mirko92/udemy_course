import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/products.dart';

class ProductManager extends StatefulWidget {
  final Product startingProduct;

  ProductManager({this.startingProduct});

  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  List<Product> _products = [];

  @override
  void initState() {
    print('[ProductManager State] initState()');
    super.initState();

    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[ProductManager State] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct() {
    setState(() {
      _products.add(Product(
          details: 'Details',
          title: 'Title',
          imageUrl: 'assets/images/food.jpg'));
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(_addProduct),
        ),
        Expanded(
          child: Products(_products, deleteProduct: _deleteProduct,),
        )
      ],
    );
  }
}

class ProductControl extends StatelessWidget {
  final Function action;

  ProductControl(this.action);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Add product'),
      onPressed: action,
    );
  }
}
