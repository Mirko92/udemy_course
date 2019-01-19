import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/model/user.dart';

mixin ConnectedProductsModel on Model{
final String url = "https://mirko-flutter-products.firebaseio.com/products.json"; 
  List<Product> products = [];
  int selProductIndex; 

  User authenticatedUser;


  void fetchProducts(){
    http.get(url).then(
      (http.Response response){

        final List<Product> fetchedProductList = [];
        final Map<String, dynamic> productListData = json.decode(response.body);

        productListData.forEach((String key, dynamic productData){
          final Product newProduct = Product(
            id: key,
            title: productData['title'],
            description: productData['description'],
            imageUrl: productData['imageUrl'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productData['userId']
          );

          fetchedProductList.add(newProduct);
        });

        products = fetchedProductList;
        notifyListeners();
      }
    );
  }

  void addProduct(String title, String description, String image, double price){
    Map<String, dynamic> data = {
      'title' : title,
      'description':description,
      'imageUrl': 'https://cdn.newsapi.com.au/image/v1/8d7ce957d8c0d9536a24cc1d50bf4da1',
      'price':price,
      'userEmail': authenticatedUser.email,
      'userId': authenticatedUser.id
    };

    http.post(url, body: json.encode(data))
    .then((http.Response response ){
      print('Respones is coming: $response');

      Map<String, dynamic> responseData = json.decode(response.body);

      final Product newProduct = Product( id: responseData['name'],
                                          title:title, 
                                          description: description, 
                                          imageUrl: image, 
                                          price: price, 
                                          userEmail: authenticatedUser.email, 
                                          userId:authenticatedUser.id);
      products.add(newProduct);
      selProductIndex=null;
      notifyListeners();
    });
  }
}