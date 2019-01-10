import 'dart:async';

import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('This action cannot be undone!'),
            actions: <Widget>[
              FlatButton(
                child: Text('DISCARD'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('DELETE'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed');
        Navigator.pop(context, false);
        return Future<bool>.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(product.imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(product.details),
            ),
            RaisedButton(
              onPressed: () => _showWarningDialog(context),
              child: Text('Delete'),
            )
          ],
        ),
      ),
    );
  }
}
