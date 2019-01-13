import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/widgets/products/address_tag.dart';
import 'package:udemy_course/widgets/products/price-tag.dart';
import 'package:udemy_course/widgets/ui_elements/title_default.dart';

class ProductCard extends StatelessWidget {
  final int index;
  final Product product;

  ProductCard(this.product, this.index);

  Widget _buildTitlePriceRow() {
    return Container(
      ///Il container è il DIV
      ///
      ///Se si vuole aggiungere solo il padding
      ///si può usare anche Padding() al posto di container
      padding: EdgeInsets.only(top: 10.0),
      // padding: EdgeInsets.all(10.0),
      // color: Colors.red,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(
            width: 8.0,
          ),
          PriceTag(product.price)
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(
              context, '/product/' + index.toString()),
        ),
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.red,
          onPressed: () => Navigator.pushNamed<bool>(
              context, '/product/' + index.toString()),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.imageUrl),
          _buildTitlePriceRow(),
          AddressTag('Qualcosa ci devo pur scrivere'),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}