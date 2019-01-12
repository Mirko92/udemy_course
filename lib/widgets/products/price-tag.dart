import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double _price;

  PriceTag(this._price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
      child: Text(
        '\$$_price',
        style: TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
