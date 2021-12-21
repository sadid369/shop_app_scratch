// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_app_scratch/provider/auth.dart';
import 'package:shop_app_scratch/screen/auth_screen.dart';
import 'package:shop_app_scratch/screen/cart_screen.dart';
import 'package:shop_app_scratch/screen/edit_product_screen.dart';
import 'package:shop_app_scratch/screen/order_screen.dart';
import 'package:shop_app_scratch/screen/product_details_screen.dart';
import 'package:shop_app_scratch/screen/product_overview_screen.dart';
import 'package:shop_app_scratch/screen/splash_screen.dart';
import 'package:shop_app_scratch/screen/user_product_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      builder: (context, child) => Consumer<Auth>(
        builder: (context, auth, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
              SplashScreen.routeName: (ctx) => SplashScreen()
            },
          );
        },
      ),
    );
  }
}
