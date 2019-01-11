import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<ProductCreatePage> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue = '';
  String descriptionValue = '';
  double priceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Product Title'),
            autofocus: true,
            onChanged: (String text) {
              setState(() {
                titleValue = text;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product Description'),
            autofocus: true,
            maxLines: 4,
            onChanged: (String text) {
              setState(() {
                descriptionValue = text;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Product Price',
            ),
            autofocus: true,
            keyboardType: TextInputType.numberWithOptions(),
            onChanged: (String value) {
              setState(() {
                priceValue = double.parse(value);
              });
            },
          ),
          SizedBox(height: 20.0,),
          RaisedButton(
            child: Text('Save'),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {
              widget.addProduct(new Product(
                  title: titleValue,
                  description: descriptionValue,
                  price: priceValue,
                  imageUrl: 'assets/images/food.jpg'));

              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
    );

    // Center(
    //     child: RaisedButton(
    //   child: Text('Save'),
    //   onPressed: () {
    //     showModalBottomSheet(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return Center(
    //             child: Text('Questo è un dialog'),
    //           );
    //         });
    //   },
    // ));
  }
}
