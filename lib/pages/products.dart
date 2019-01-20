import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/scoped-models/main.dart';
import 'package:udemy_course/widgets/products/products.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  _ProductsPageState createState() => _ProductsPageState();

}
class _ProductsPageState extends State<ProductsPage>{

  @override
  initState(){
    widget.model.fetchProducts();
    super.initState();
  }
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('Choose'),
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Products'),
          onTap: () {
            print('[ProductsPage Drawer] onTap()');
            Navigator.pushReplacementNamed(context, '/admin');
          },
        )
      ],
    ));
  }

  Widget _buildProductList(){
    return ScopedModelDescendant<MainModel>(builder: (context, widget, model){
      Widget content = Center(child:Text('No products found!'));
      if (model.displayedProducts.length > 0 && !model.isLoading){
        content = Products();
      }else if(model.isLoading){
        content = Center(child: CircularProgressIndicator(),);
      }
      return RefreshIndicator(onRefresh: model.fetchProducts,child:content);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('Product list'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder:
                (BuildContext context, Widget widget, MainModel model) {
              return IconButton(
                icon: Icon(
                  model.displayedFavoritesOnly ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          ),
        ],
      ),
      body: _buildProductList(),
    );
  }
}
