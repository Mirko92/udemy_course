import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/scoped-models/main.dart';

import './product_edit.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model; 

  ProductListPage(this.model);
  
  @override
   _ProductListPageState createState() => _ProductListPageState();

}

class _ProductListPageState extends State<ProductListPage>{

  @override
  initState(){
    widget.model.fetchProducts(onlyForUser: true);
    super.initState();
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(
        Icons.edit,
        color: Colors.red,
      ),
      onPressed: () {
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
            },
          ),
        ).then((_) => model.selectProduct(null));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget widget, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.allProducts[index].id),
              direction: DismissDirection.endToStart,
              onDismissed: (DismissDirection value) {
                if (value == DismissDirection.endToStart) {
                  model.selectProduct(model.allProducts[index].id);
                  model.deleteProduct();
                }
              },
              background: Container(
                color: Colors.red,
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10.0),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          model.allProducts[index].imageUrl,
                        ),
                      ),
                      title: Text(model.allProducts[index].title),
                      subtitle: Text(
                          '\$${model.allProducts[index].price.toString()}'),
                      trailing: _buildEditButton(context, index, model)),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.allProducts.length,
        );
      },
    );
  }
}
