import 'package:flutter/widgets.dart';

class Product with ChangeNotifier {
  String? id;
  double? price;
  String? description;
  String? imageUrl;
  String? title;
  bool isFavorite;
  Product({
    required this.id,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.title,
    this.isFavorite = false,
  });
}
