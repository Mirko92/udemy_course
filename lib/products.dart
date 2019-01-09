import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/pages/product.dart';

class Products extends StatelessWidget {
  final List<Product> products;
  final Function deleteProduct;
  Products(this.products, {this.deleteProduct});

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/food.jpg'),
          Text(products[index].title),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () {
                  Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ProductPage(products[index]))).then((bool val){
                                if ( val ){
                                  deleteProduct(index);
                                }
                              });
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductLists() {
    Widget productCard = Center(
      child: Text('No products found, please add some'),
    );
    if (products.length > 0) {
      productCard = ListView.builder(
          itemBuilder: _buildProductItem, itemCount: products.length);
    }

    /* E' importante non ritornare mai un Widget undefined, meglio un Container() vuoto */
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return _buildProductLists();

    ///La lista sotto, pur avendo la capacità di aggiungere lo scroll
    ///e quindi di essere completamente visibile nel dispositivo
    ///carica in memoria all'istante iniziale tutto il contenuto
    //  ListView(
    //   children: products
    //       .map((element) => Card(
    //             child: Column(
    //               children: <Widget>[
    //                 Image.asset('assets/images/billy.jpg'),
    //                 Text(element)
    //               ],
    //             ),
    //           ))
    //       .toList(),
    // );
  }
}
