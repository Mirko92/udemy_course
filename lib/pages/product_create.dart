import 'package:flutter/material.dart';
import 'package:udemy_course/model/product.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<ProductCreatePage> createState() => _ProductCreatePageState();
}

///Best Practice: 
///Le property di una classe privata "_NomeClasse" devono essere private "_NomeProperty"
class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue        = '';
  String _descriptionValue  = '';
  double _priceValue;

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
                _titleValue = text;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product Description'),
            autofocus: true,
            maxLines: 4,
            onChanged: (String text) {
              setState(() {
                _descriptionValue = text;
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
                _priceValue = double.parse(value);
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
                  title: _titleValue,
                  description: _descriptionValue,
                  price: _priceValue,
                  imageUrl: 'assets/images/food.jpg'));

              Navigator.pushReplacementNamed(context, '/products');
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
