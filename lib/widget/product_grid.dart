// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_scratch/provider/cart.dart';
import 'package:shop_app_scratch/provider/products.dart';
import 'package:shop_app_scratch/screen/product_details_screen.dart';
import 'package:shop_app_scratch/screen/product_overview_screen.dart';

class ProductGrid extends StatefulWidget {
  bool? isFavorite;
  ProductGrid({
    this.isFavorite,
  });

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  // @override
  // void initState() {
  //   Provider.of<Products>(context, listen: false).setAndFetchProduct();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('ProductGrid');

    final products = Provider.of<Products>(context);

    final productList =
        widget.isFavorite! ? products.favoriteList : products.items;
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: productList[i].id,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: Image.network('${products.items[i].imageUrl}'),
            footer: GridTileBar(
              backgroundColor: Colors.black12,
              leading: IconButton(
                color: productList[i].isFavorite ? Colors.blue : Colors.black,
                onPressed: () async {
                  await products.userFavorite(
                      productList[i].id!, productList[i].isFavorite);
                  await products.setAndFetchProduct();
                },
                icon: Icon(productList[i].isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Provider.of<Carts>(context, listen: false)
                        .addCartItem(productList[i]);
                  },
                  icon: Icon(Icons.shopping_basket_outlined)),
            ),
          ),
        ),
      ),
    );
  }
}
