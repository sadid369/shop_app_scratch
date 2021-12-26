// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shop_app_scratch/provider/products.dart';
import 'package:shop_app_scratch/screen/edit_product_screen.dart';
import 'package:shop_app_scratch/widget/drawer_widget.dart';
import 'package:provider/provider.dart';

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
    Provider.of<Products>(context, listen: false).setAndFetchProduct();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: Icon(Icons.edit))
        ],
      ),
      drawer: DrawerWidget(),
      body: FutureBuilder(
        future:
            Provider.of<Products>(context, listen: false).setAndFetchProduct(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Products>(
                  builder: (context, products, child) {
                    return GridView.builder(
                      itemCount: products.items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (ctx, i) => ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GridTile(
                          child: Image.network('${products.items[i].imageUrl}'),
                          footer: GridTileBar(
                            backgroundColor: Colors.black12,
                            leading: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.shopping_basket_outlined)),
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
