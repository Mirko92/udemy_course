import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';

class Products extends StatelessWidget {
  final List<Product> products;

  Products(this.products) {
    print('[Products Widget] Constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index].imageUrl),

          //Simile allo spacer di PrimeFaces
          // SizedBox(height: 10.0,),

          Container(
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
                Text(
                  products[index].title,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald'),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
                  child: Text(
                    '\$${products[index].price}',
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, style: BorderStyle.solid, color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0)),
            child: Text('Qualcosa ci devo pur scrivere'),
          ),

          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + index.toString()),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    } else {
      productCards = Container();
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return _buildProductList();
  }
}
