import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

///Best Practice:
///Le property di una classe privata "_NomeClasse" devono essere private "_NomeProperty"
class _ProductEditPageState extends State<ProductEditPage> {
  final Product _formData = Product();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      autofocus: true,
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        if (value.trim().isEmpty || value.trim().length <= 5) {
          return "Title is required, and should be 5+ characters long.";
        }
      },
      onSaved: (String newValue) {
        _formData.title = newValue;
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 3,
      initialValue: product == null ? '' : product.description,
      validator: (String value) {
        if (value.trim().isEmpty || value.trim().length <= 10) {
          return "Description is required, and should be 10+ characters long.";
        }
      },
      onSaved: (String newValue) {
        _formData.description = newValue;
      },
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      initialValue: product == null ? '' : product.price.toString(),
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
        _formData.price = double.parse(newValue);
      },
    );
  }

  void _submitForm(Function addProduct, Function updateProduct, Function setSelectedProduct, [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    ///Ogni volta che viene chiamato, chiama il metodo salva di tutti i campi input interni alla form
    _formKey.currentState.save();
    _formData.imageUrl = 'assets/images/food.jpg';

    if (selectedProductIndex == null) {
      addProduct(_formData.title, _formData.description, _formData.imageUrl, _formData.price);
    } else {
      updateProduct(_formData.title, _formData.description, _formData.imageUrl, _formData.price);
    }

    Navigator.pushReplacementNamed(context, '/products').then((_)=> setSelectedProduct(null));
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget widget, MainModel model) {
        return RaisedButton(
          child: Text('Save'),
          textColor: Colors.white,
          onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectProduct, model.selectedProductIndex),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    Widget _buildPageContent(BuildContext context, Product product) {
      return Container(
        width: targetWidth,
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          // autovalidate: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(
                height: 20.0,
              ),
              _buildSubmitButton(),
            ],
          ),
        ),
      );
    }

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget widget, MainModel model) {
      final Widget pageContent =
          _buildPageContent(context, model.selectedProduct);
      return model.selectedProductIndex == null
          ? pageContent
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit Product'),
              ),
              body: pageContent,
            );
    });
  }
}
