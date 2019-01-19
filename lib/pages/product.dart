import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/scoped-models/main.dart';
import 'package:udemy_course/widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final int index;

  ProductPage(this.index);
  
  Widget _buildAddressPriceRow(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Qualcosa devo pur scrivere',
            style: TextStyle(fontFamily: 'Oswald', color: Colors.grey)),
        Container(
          child: Text(
            '|',
          ),
          margin: EdgeInsets.symmetric(horizontal: 5.0),
        ),
        Text('\$' + product.price.toString(),
            style: TextStyle(fontFamily: 'Oswald', color: Colors.green))
      ],
    );
  }

  Widget _buildDescriptionContainer(Product product) {
    return Container(
        padding: EdgeInsets.all(10.0),
        // margin: EdgeInsets.only(top:10.0),
        child: Text(
          product.description,
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
          textAlign: TextAlign.center,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed');
        Navigator.pop(context, false);
        return Future<bool>.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
        builder:
            (BuildContext context, Widget widget, MainModel productModel) {
          final Product product = productModel.allProducts[index];
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(product.imageUrl),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TitleDefault(product.title),
                ),
                _buildAddressPriceRow(product),
                _buildDescriptionContainer(product),
              ],
            ),
          );
        },
      ),
    );
  }
}




// _showWarningDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Are you sure?'),
  //           content: Text('This action cannot be undone!'),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('DISCARD'),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             FlatButton(
  //               child: Text('DELETE'),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 Navigator.pop(context, true);
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }