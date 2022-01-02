// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_scratch/provider/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    final cartItemData = Provider.of<Carts>(context);
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              child: Card(
                elevation: 8,
                child: Row(
                  children: [
                    Text('Total'),
                    Chip(
                        label:
                            Text('${Provider.of<Carts>(context).granTotal()}'))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 500,
              child: Card(
                child: ListView.builder(
                  itemCount: cartItemData.cartItem.length,
                  itemBuilder: (ctx, i) => Dismissible(
                    key: ValueKey(cartItemData.cartItem[i].id),
                    onDismissed: (value) {
                      cartItemData.removeItem(cartItemData.cartItem[i].id);
                    },
                    background: Container(
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                    confirmDismiss: (direction) {
                      return showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: Text('Are you sure?'),
                              content: Text(
                                  'This will delete your item: ${cartItemData.cartItem[i].title}'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop(true);
                                  },
                                  child: Text('yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop(false);
                                  },
                                  child: Text('No'),
                                ),
                              ],
                            );
                          });
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child:
                            Image.network(cartItemData.cartItem[i].imageUrl!),
                      ),
                      title: Text(cartItemData.cartItem[i].title!),
                      trailing: Text(
                          '${cartItemData.cartItem[i].itemTotalPeice}  ${cartItemData.cartItem[i].price}'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
