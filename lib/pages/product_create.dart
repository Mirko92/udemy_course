import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  @override
  State<ProductCreatePage> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleText = '';
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
                titleText = text;
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
          RaisedButton(
            child: Text('Save'),
            onPressed: () {
              
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
