import 'package:flutter/widgets.dart';
import 'package:shop_app_scratch/provider/product.dart';

class Cart with ChangeNotifier {
  String? id;
  String? title;
  String? imageUrl;
  String? description;
  double? price;
  double? itemTotalPeice;

  Cart({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.itemTotalPeice,
  });
}

class Carts with ChangeNotifier {
  List<Cart> _cartItem = [];
  List<Cart> get cartItem {
    return [..._cartItem];
  }

  void addCartItem(Product product) {
    int? cartIdex;
    cartIdex = _cartItem.indexWhere((cartItem) => cartItem.id == product.id);
    print(cartIdex);
    if (cartIdex >= 0) {
      var existingItem = _cartItem[cartIdex];
      var price = product.price! + existingItem.price!;
      var piceOfItem = existingItem.itemTotalPeice! + 1;
      _cartItem[cartIdex] = Cart(
          itemTotalPeice: piceOfItem,
          id: existingItem.id,
          title: existingItem.title,
          imageUrl: existingItem.imageUrl,
          description: existingItem.description,
          price: price);
      notifyListeners();
    } else {
      final cartItem = Cart(
          itemTotalPeice: 1,
          id: product.id,
          title: product.title,
          imageUrl: product.imageUrl,
          description: product.description,
          price: product.price);
      _cartItem.add(cartItem);
      notifyListeners();
    }

    // print(_cartItem);
    // notifyListeners();
  }

  void removeItem(String? id) {
    final indexNum = _cartItem.indexWhere((cartI) => cartI.id == id);
    _cartItem.removeAt(indexNum);
    notifyListeners();
  }

  double granTotal() {
    double grandTotal = 0;
    for (var i = 0; i < cartItem.length; i++) {
      grandTotal =
          grandTotal + (cartItem[i].itemTotalPeice! * cartItem[i].price!);
    }
    return grandTotal;
  }
}
