import 'package:flutter/cupertino.dart';
import 'package:shop_app_scratch/provider/cart.dart';

class Order with ChangeNotifier {
  String? id;
  String? title;
  String? imageUrl;
  String? description;
  double? price;
  double? itemTotalPeice;

  Order({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.itemTotalPeice,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orderitems = [];
  List<Order> get orderItem {
    return [..._orderitems];
  }
}
