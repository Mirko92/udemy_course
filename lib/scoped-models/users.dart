import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/model/user.dart';

mixin UsersModel on Model{
  User _authenticatedUser;


  void login(String email, String password){
    _authenticatedUser = new User(id:'stica', email: email, password: password);
  }
}