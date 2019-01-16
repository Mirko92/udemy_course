import 'package:flutter/material.dart';

class Product {
  final String title;

  final String description;

  final String imageUrl;

  final String details;

  final double price;

  Product(
      {@required this.title,
      @required this.description,
      @required this.imageUrl,
      this.details,
      @required this.price});
}
