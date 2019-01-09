import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/billy.jpg'),
          Text(products[index])
        ],
      ),
    );
  }

  Products(this.products);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: products.length,
    );

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
