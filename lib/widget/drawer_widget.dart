import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_scratch/provider/auth.dart';
import 'package:shop_app_scratch/screen/edit_product_screen.dart';
import 'package:shop_app_scratch/screen/order_screen.dart';
import 'package:shop_app_scratch/screen/user_product_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Edit Products'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(UserProductScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop_rounded),
            title: const Text('My Order Page'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
