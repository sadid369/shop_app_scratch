// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_scratch/provider/order.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = 'OrderScreen';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    print(orders.orderItem[0].title);
    return Scaffold(
        appBar: AppBar(
          title: Text('Order Page'),
        ),
        body: ListView.builder(
            itemCount: orders.orderItem.length,
            itemBuilder: (ctx, i) => ListTile(
                  // leading: CircleAvatar(
                  //   child: Image.network(orders.orderItem[i].imageUrl!),
                  // ),
                  title: Text(orders.orderItem[i].title!),
                  trailing: Text(orders.orderItem[i].price.toString()),
                )));
  }
}
