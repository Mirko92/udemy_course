import 'package:flutter/material.dart';

class Product {
  final String id;
  String title;
  String description;
  String imageUrl;
  double price;

  bool isFavorite;
  final String userEmail;
  final String userId;

  Map<String, bool> wishlistUsers;

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


  Product.fromJson(Map<String, dynamic> json, String id)
    : id    = id,
      price = json['price'],
      title       = json['title'],
      description = json['description'],
      imageUrl    = json['imageUrl'],
      userEmail   = json['userEmail'],
      userId      = json['userId'],

      wishlistUsers = json['wishlistUsers'] != null ? 
        (json['wishlistUsers'] as Map<String, dynamic>).map( (key, value)=> MapEntry<String, bool>(key, value == true)) 
        : null ;
              


  Map<String, String> toJson() => {
    'id':this.id,
    'title':this.title,
    'description':this.description,
    'imageUrl':this.imageUrl,
    'price':this.price.toString(),
    'isFavorite':this.isFavorite.toString(),
    'userEmail':this.userEmail,
    'userId':this.userId,
  };
}
