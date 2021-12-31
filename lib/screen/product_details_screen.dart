// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_scratch/provider/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'ProductDetailScreen';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final productdId = ModalRoute.of(context)!.settings.arguments as String;
    final productList =
        Provider.of<Products>(context).productDetails(productdId);
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (ctx, i) => Container(
                  height: deviceSize.height,
                  width: deviceSize.width * 0.50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.network(productList[i].imageUrl!),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '\$ ${productList[i].title}',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '\$ ${productList[i].price}',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '\$ ${productList[i].description}',
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                )));
  }
}
