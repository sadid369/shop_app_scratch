// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_scratch/provider/product.dart';
import 'package:shop_app_scratch/provider/products.dart';
import 'package:shop_app_scratch/screen/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'UserProductScreen';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.items.length,
        itemBuilder: (ctx, i) => Card(
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              child: Image.network('${products.items[i].imageUrl}'),
            ),
            title: Text('${products.items[i].title}'),
            trailing: Container(
              height: 60,
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            EditProductScreen.routeName,
                            arguments: products.items[i].id);
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
