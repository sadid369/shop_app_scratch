// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shop_app_scratch/provider/cart.dart';
import 'package:shop_app_scratch/provider/products.dart';
import 'package:shop_app_scratch/screen/cart_screen.dart';
import 'package:shop_app_scratch/screen/edit_product_screen.dart';
import 'package:shop_app_scratch/screen/product_details_screen.dart';
import 'package:shop_app_scratch/widget/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_scratch/widget/product_grid.dart';

enum IsFav { favorite, all }
bool isFavorite = false;
bool init = true;

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = 'ProductOverviewScreen';

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  // @override
  // void initState() {
  //   Provider.of<Products>(context, listen: false).setAndFetchProduct();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (init) {
      Provider.of<Products>(context).setAndFetchProduct();
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('productOverviewPageBuilder');

    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
                onSelected: (IsFav isFavoriteEnum) {
                  if (isFavoriteEnum == IsFav.favorite) {
                    setState(() {
                      isFavorite = true;
                    });
                  } else {
                    setState(() {
                      isFavorite = false;
                    });
                  }
                },
                itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text('Favorite'),
                        value: IsFav.favorite,
                      ),
                      PopupMenuItem(
                        child: Text('All'),
                        value: IsFav.all,
                      )
                    ]),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(Icons.shop_2_rounded))
          ],
        ),
        drawer: DrawerWidget(),
        body: ProductGrid(
          isFavorite: isFavorite,
        ));
  }
}
