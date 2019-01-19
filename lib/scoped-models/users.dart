import 'package:udemy_course/model/user.dart';
import 'package:udemy_course/scoped-models/connected_products.dart';

mixin UsersModel on ConnectedProductsModel{
  void login(String email, String password){
    authenticatedUser = new User(id:'stica', email: email, password: password);
  }
}