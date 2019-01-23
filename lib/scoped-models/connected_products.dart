import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/auth.dart';
import 'package:udemy_course/model/product.dart';
import 'package:udemy_course/model/user.dart';
import 'package:udemy_course/model/utils.dart';

mixin ConnectedProductsModel on Model {
  /// Url per i prodotti su FireBase
  final String productsUrl =
      "https://mirko-flutter-products.firebaseio.com/products";

  /// Lista di prodotti in memoria
  List<Product> _products = [];

  /// Utente che ha effettuato l'accesso
  User _authenticatedUser;

  /// Id del prodotto selezionato
  String _selProductID;

  /// Flag: Indica se si sta aspettando una chiamata asincrona o meno
  bool _isLoading = false;
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  Future<bool> fetchProducts() {
    _isLoading = true;
    notifyListeners();

    return http.get(productsUrl + '.json').then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      }

      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);

      if (productListData != null) {
        productListData.forEach((String key, dynamic productData) {
          final Product newProduct = Product(
              id: key,
              title: productData['title'],
              description: productData['description'],
              imageUrl: productData['imageUrl'],
              price: productData['price'],
              userEmail: productData['userEmail'],
              userId: productData['userId']);

          fetchedProductList.add(newProduct);
        });

        _products = fetchedProductList;
      }

      _isLoading = false;
      notifyListeners();
      _selProductID = null;
      return true;
    }).catchError((onError) {
      print('Something went wrong');
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> addProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'imageUrl':
          'https://cdn.newsapi.com.au/image/v1/8d7ce957d8c0d9536a24cc1d50bf4da1',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };

    return http
        .post(productsUrl + '.json', body: json.encode(data))
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      Map<String, dynamic> responseData = json.decode(response.body);

      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          imageUrl: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _selProductID = null;
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((onError) {
      print('Something went wrong');
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  String get selectedProductID {
    return _selProductID;
  }

  Product get selectedProduct {
    return selectedProductID != null
        ? _products.firstWhere((Product x) => x.id == _selProductID)
        : null;
  }

  int get selectedIndex {
    return _products.indexWhere((Product p) => p.id == _selProductID);
  }

  bool get displayedFavoritesOnly {
    return _showFavorites;
  }

  Future<bool> updateProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'imageUrl':
          'https://cdn.newsapi.com.au/image/v1/8d7ce957d8c0d9536a24cc1d50bf4da1',
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId,
    };

    return http
        .put(productsUrl + '/${selectedProduct.id}.json',
            body: json.encode(updateData))
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((onError) {
      print('Something went wrong');
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteProduct() {
    _isLoading = true;

    final String deletedId = selectedProduct.id;
    _products.removeAt(selectedIndex);

    _selProductID = null;
    notifyListeners();

    return http
        .delete(productsUrl + '/$deletedId' + '.json')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((onError) {
      print('Something went wrong');
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void selectProduct(String productId) {
    _selProductID = productId;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        imageUrl: selectedProduct.imageUrl,
        price: selectedProduct.price,
        isFavorite: !selectedProduct.isFavorite,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);

    _products[selectedIndex] = updatedProduct;

    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UsersModel on ConnectedProductsModel {
  final String signupUrl =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyB_XDP0sftDbqQcVDov8LgRLODiNu2YbmU';
  final String authUrl = 
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyB_XDP0sftDbqQcVDov8LgRLODiNu2YbmU';

  Future<MyHttpResponse> authenticate(String email, String password, [AuthMode mode = AuthMode.Login]){
    _isLoading = true;
    notifyListeners();

    Future<http.Response> response;

    if(mode == AuthMode.Login){
      response = http.post(authUrl,
        body: json.encode( {'email': email, 'password': password, 'returnSecureToken': true} ),
        headers: { 'Content-Type': 'application/json' });
    }else{
      final FireBaseAuthRequest requestPayload = FireBaseAuthRequest(email: email, password: password);
      response = http.post(signupUrl, body: requestPayload.toJson());
    }

    return response.then((http.Response response) {
      print('${mode == AuthMode.Login ? 'SignIn' : 'SignUp'} Response: ' + response.toString());

      final FireBaseResponse responseData =
          FireBaseResponse.fromJson(json.decode(response.body));

      bool success = true;
      var message = 'Authentication succeded!';
      if (responseData.idToken == null) {
        success = false;
        message = 'Something went wrong';
        if (responseData.error.message == 'EMAIL_EXISTS') {
          message = 'This email already exists';
        }
        if (responseData.error.message == 'EMAIL_NOT_FOUND') {
          message = 'This email was not found';
        }
        if (responseData.error.message == 'INVALID_PASSWORD') {
          message = 'This password is invalid';
        }
      }

      _isLoading = false;
      notifyListeners();

      return MyHttpResponse(result: success, message: message);
    });

  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}





// Future<MyHttpResponse> signup(String email, String password) {
  //   _isLoading = true;
  //   notifyListeners();

  //   return http.post(signupUrl,
  //       body: json.encode( {'email': email, 'password': password, 'returnSecureToken': true} ),
  //       headers: { 'Content-Type': 'application/json' })
  //       .then((http.Response response) {

  //     print('Signup Response: ' + response.toString());

  //     final FireBaseResponse responseData =
  //         FireBaseResponse.fromJson(json.decode(response.body));

  //     bool success = true;
  //     var message = 'Authentication succeded!';
  //     if (responseData.idToken == null) {
  //       success = false;
  //       message = 'Something went wrong';
  //       if (responseData.error.message == 'EMAIL_EXISTS') {
  //         message = 'This email already exists';
  //       }
  //     }
  //     _isLoading = false;
  //     notifyListeners();

  //     return MyHttpResponse(result: success, message: message);
  //   });
  // }

  // Future<MyHttpResponse> login(String email, String password) {
    
  //   final FireBaseAuthRequest requestPayload = FireBaseAuthRequest(email: email, password: password);

  //   var authRequest = http.post(signInUrl, body: requestPayload.toJson());

  //   authRequest.then((http.Response response){
  //     print('Signup Response: ' + json.decode(response.body));
  //     final FireBaseAuthResponse responseData = FireBaseAuthResponse.fromJson(json.decode(response.body));
  //     print(responseData);
      
  //   });
  //   return null;
  // }