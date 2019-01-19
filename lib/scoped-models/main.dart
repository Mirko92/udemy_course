import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_course/scoped-models/connected_products.dart';
import 'package:udemy_course/scoped-models/products.dart';
import 'package:udemy_course/scoped-models/users.dart';

class MainModel extends Model with ConnectedProductsModel, ProductsModel, UsersModel{

}