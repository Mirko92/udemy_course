import 'package:flutter/material.dart';

class Product {
  final String id;
  String title;
  String description;
  String imageUrl;
  double price;
  final bool isFavorite;
  final String userEmail;
  final String userId;

  Product(
      {
        @required this.id,
        @required this.title,
        @required this.description,
        @required this.imageUrl,
        @required this.price,
        this.isFavorite = false,
        @required this.userEmail,
        @required this.userId
      }
  );
}
