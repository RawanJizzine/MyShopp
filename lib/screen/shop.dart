import 'package:app/screen/authscreen.dart';
import 'package:app/screen/homescreen.dart';
import 'package:app/screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/auth.dart';


class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);
static const routeName = '/dddd';
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) => auth.isAuth
          ? Myhome()
          : FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (ctx, authResultSnapshot) =>
                  authResultSnapshot.connectionState == ConnectionState.waiting
                      ? SplashScreen()
                      : AuthScreen(),
            ),
    );
  }
}