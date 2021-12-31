import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_app_scratch/provider/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  String? authToken;
  String? userId;
  Products(this.authToken, this.userId, this._items);
  Future<void> addProduct(Product product) async {
    final url =
        'https://shop-app-scratch-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl
          }));
      print(json.decode(response.body));
      // final newProduct = Product(
      //     id: json.decode(response.body)['name'],
      //     price: product.price,
      //     description: product.description,
      //     imageUrl: product.imageUrl,
      //     title: product.title);
      // _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> userFavorite(String productId, bool isFavorite) async {
    final url =
        'https://shop-app-scratch-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorite/$productId.json?auth=$authToken';
    isFavorite = !isFavorite;
    try {
      final response =
          await http.put(Uri.parse(url), body: json.encode(isFavorite));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Product> productDetails(String id) {
    return _items.where((product) => product.id == id).toList();
  }

  List<Product> get favoriteList {
    return _items.where((products) => products.isFavorite == true).toList();
  }

  Future<void> setAndFetchProduct() async {
    final url =
        'https://shop-app-scratch-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken';
    try {
      List<Product> loadedItem = [];
      final response = await http.get(Uri.parse(url));
      final fetchData = json.decode(response.body) as Map<String, dynamic>;
      if (fetchData == null) {
        return;
      }
      final favUrl =
          'https://shop-app-scratch-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorite.json?auth=$authToken';
      final favResponse = await http.get(Uri.parse(favUrl));
      final favData = json.decode(favResponse.body);
      fetchData.forEach((productId, productData) {
        loadedItem.add(Product(
            isFavorite: favData == null ? false : favData[productId] ?? false,
            id: productId,
            price: productData['price'],
            description: productData['description'],
            imageUrl: productData['imageUrl'],
            title: productData['title']));
      });
      print(loadedItem);
      _items = loadedItem;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
