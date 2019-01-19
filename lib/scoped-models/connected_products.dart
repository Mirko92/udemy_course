import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/model/user.dart';

mixin ConnectedProductsModel on Model{

  List<Product> products = [];
  int selProductIndex; 

  User authenticatedUser;

  void addProduct(String title, String description, String image, double price){
    final Product newProduct = Product(title:title, description: description, imageUrl: image, price: price, 
    email: authenticatedUser.email, id:authenticatedUser.id);
    products.add(newProduct);

    selProductIndex=null;

    notifyListeners();
  }
}