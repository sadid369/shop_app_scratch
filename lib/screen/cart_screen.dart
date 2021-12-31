// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_scratch/provider/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Carts>(context).cartItem;
    return Scaffold(
      appBar: AppBar(),
      body: Card(
        child: ListView.builder(
          itemCount: cartItem.length,
          itemBuilder: (ctx, i) => ListTile(
            leading: CircleAvatar(
              child: Image.network(cartItem[i].imageUrl!),
            ),
            title: Text(cartItem[i].title!),
            trailing:
                Text('${cartItem[i].itemTotalPeice}  ${cartItem[i].price!}'),
          ),
        ),
      ),
    );
  }
}
