// ignore_for_file: file_names

import 'package:app/Providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import '../Providers/auth.dart';
import '../screen/languagescreen.dart';
import '../screen/ordersscreen.dart';
import '../screen/userproductscreen.dart';

class AppDrawer extends StatefulWidget {
  static const routeName = '/drawer';

  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int ppp = 0;

  final translator = GoogleTranslator();

  @override
  Widget build(BuildContext context) {
    final proo = Provider.of<Products>(context);

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: const Color.fromARGB(255, 22, 173, 22),
            title: const Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Fruits and Vegetabls'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language '),
            onTap: () {
              Navigator.of(context).pushNamed(LanguageWidget.routeName);
              /* setState(() async {
                ppp = 1;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setInt('num', ppp);
              }); */
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');

              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
            },
          ),
        ],
      ),
    );
  }
}
