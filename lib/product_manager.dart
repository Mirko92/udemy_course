import 'package:flutter/material.dart';
import 'package:udemy_course/products.dart';

class ProductManager extends StatefulWidget {
  String startingProduct;

  ProductManager({this.startingProduct});

  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
    void initState() {
      print('[ProductManager State] initState()');
      super.initState();

      if(widget.startingProduct != null){
        _products.add(widget.startingProduct);
      }
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                _products.add('Advanced foot tester');
              });
            },
            child: Text('Add Product'),
          ),
        ),
        Expanded(
          child: Products(_products),
        )
      ],
    );
  }
}
