import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_app_scratch/provider/cart.dart';
import 'package:http/http.dart' as http;

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
  String? authToken;
  String? userId;
  Orders(this._orderItems, this.authToken, this.userId);
  List<Order> _orderItems = [];
  List<Order> get orderItem {
    return [..._orderItems];
  }

  Future<void> addOrder(List<Cart> cartItem) async {
    final url =
        'https://shop-app-scratch-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken';
    List<Order> loadedList = [];

    for (var i = 0; i < cartItem.length; i++) {
      await http
          .post(Uri.parse(url),
              body: json.encode({
                'id': cartItem[i].id,
                'title': cartItem[i].title,
                'imageUrl': cartItem[i].imageUrl,
                'description': cartItem[i].description,
                'price': cartItem[i].price,
                'itemTotalPeice': cartItem[i].itemTotalPeice,
              }))
          .then((response) {
        loadedList.add(Order(
            id: cartItem[i].id,
            title: cartItem[i].title,
            imageUrl: cartItem[i].imageUrl,
            description: cartItem[i].description,
            price: cartItem[i].price));
      });
    }
    // await http.post(
    //   Uri.parse(url),
    //   body: json.encode({}),
    // );
    // cartItem.forEach((cartItems) async {
    //   await http
    //       .post(
    //     Uri.parse(url),
    //     body: json.encode({}),
    //   )
    //       .then((response) {
    //     loadedList.add(
    //       Order(
    //         id: cartItems.id,
    //         title: cartItems.title,
    //         imageUrl: cartItems.imageUrl,
    //         description: cartItems.description,
    //         price: cartItems.price,
    //       ),
    //     );
    //   }).catchError((error) => print(error));
    // });

    // cartItem.forEach((cartItem) {
    //   loadedList.add(Order(
    //       id: cartItem.id,
    //       title: cartItem.title,
    //       imageUrl: cartItem.imageUrl,
    //       description: cartItem.description,
    //       price: cartItem.price));
    // });
    _orderItems.addAll(loadedList);
    notifyListeners();
  }
}
