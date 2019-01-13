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
  String _titleValue = '';
  String _descriptionValue = '';
  double _priceValue;
  final GlobalKey<FormState> _formKey = GlobalKey();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      autofocus: true,
      validator: (String value) {
        if (value.trim().isEmpty || value.trim().length <= 5) {
          return "Title is required, and should be 5+ characters long.";
        }
      },
      onSaved: (String newValue) {
        setState(() {
          _titleValue = newValue;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 3,
      validator: (String value) {
        if (value.trim().isEmpty || value.trim().length <= 10) {
          return "Description is required, and should be 10+ characters long.";
        }
      },
      onSaved: (String newValue) {
        setState(() {
          _descriptionValue = newValue;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      autofocus: true,
      keyboardType: TextInputType.numberWithOptions(),
      validator: (String value) {
        if (value == null ||
            value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
          return "Price is required and should be a number";
        }
      },
      onSaved: (String newValue) {
        setState(() {
          _priceValue = double.parse(newValue);
        });
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    ///Ogni volta che viene chiamato, chiama il meto salva di tutti i campi input interni alla form
    _formKey.currentState.save();
    widget.addProduct(new Product(
        title: _titleValue,
        description: _descriptionValue,
        price: _priceValue,
        imageUrl: 'assets/images/food.jpg'));
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
      width: targetWidth,
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        // autovalidate: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          children: <Widget>[
            _buildTitleTextField(),
            _buildDescriptionTextField(),
            _buildPriceTextField(),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Save'),
              textColor: Colors.white,
              onPressed: _submitForm,
            )
          ],
        ),
      ),
    );
  }
}
