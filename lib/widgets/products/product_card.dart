import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/scoped-models/main.dart';
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
    return ScopedModelDescendant<MainModel>(
      rebuildOnChange: true,
      builder: (BuildContext context, Widget widget, MainModel model) {
        return ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              color: Theme.of(context).accentColor,
              onPressed: () => Navigator.pushNamed<bool>(
                  context, '/product/' + model.allProducts[index].id),
            ),
            IconButton(
              icon: Icon(model.allProducts[index].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                model.selectProduct(model.allProducts[index].id);
                model.toggleProductFavoriteStatus();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(product.imageUrl),
            placeholder: AssetImage('assets/images/background.jpg'),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          _buildTitlePriceRow(),
          AddressTag('Qualcosa ci devo pur scrivere'),
          Text(product.userEmail),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}
