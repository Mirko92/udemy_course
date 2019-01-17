import 'package:flutter/material.dart';

class Product {
  String title;
  String description;
  String imageUrl;
  double price;
  Product(
      {@required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.price});
}
