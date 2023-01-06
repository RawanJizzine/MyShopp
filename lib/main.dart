import 'package:app/Providers/auth.dart';
import 'package:app/screen/authscreen.dart';
import 'package:app/screen/cartscreen.dart';

import 'package:app/screen/detailsscreen.dart';

import 'package:app/screen/editproductscreen.dart';
import 'package:app/screen/homescreen.dart';
import 'package:app/screen/languagescreen.dart';

import 'package:app/screen/ordersscreen.dart';
import 'package:app/screen/shop.dart';
import 'package:app/screen/splashscreen.dart';
import 'package:app/screen/userproductscreen.dart';
import 'package:app/translations/codegen.dart';
import 'package:app/widgets/Drawer.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';


//import 'package:intl/date_symbols.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Providers/cart.dart';
import 'Providers/orders.dart';
import 'Providers/products.dart';

const debug = true;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize();
  await EasyLocalization.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('num', 0);
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        child: MyApppp(),
      ),

      //  builder: (context) => const MyApppp(),
    ),
  );
 
}

class MyApppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*  var themeData = ThemeData(
            fontFamily: 'Lato', 
            primaryColor: const Color.fromARGB(255, 22, 173, 22),
            
          ); */
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products('', '', []),
          update: (context, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders('', '', []),
          update: (context, auth, previousOrder) => Orders(
            auth.token,
            auth.userId,
            previousOrder == null ? [] : previousOrder.orders,
          ),
        ),
      ],
      child: Builder(
          // Here the magic happens
          // this builder function will generate a new BuilContext for you
          builder: (BuildContext newContext) {
        return MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(newContext),
          builder: DevicePreview.appBuilder,
          title: 'MyShop',
          theme: ThemeData(
            fontFamily: 'Lato',
            primaryColor: const Color.fromARGB(255, 22, 173, 22),
          ),

          /* home: auth.isAuth
              ? Myhome()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ), */
          /*auth.isAuth
              ? const Myhome()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                  
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),*/

          //MyLogin(),
          routes: <String, WidgetBuilder>{
            Myhome.routeName: (newContext) => const Myhome(),
            SplashScreen.routeName: (newContext) => SplashScreen(),
            AuthScreen.routeName: (newContext) => AuthScreen(),
            // Myhome.routeName: (ctx) => const Myhome(),
            // '/product-detail': (ctx) => const Details(),
            Details.routeName: (newContext) => Details(
                  value: '',
                ),
            // CartScreen.routeName: (context) => const CartScreen(),
            AppDrawer.routeName: (newContext) => const AppDrawer(),
            OrdersScreen.routeName: (newContext) => const OrdersScreen(),
            UserProductsScreen.routeName: (newContext) =>
                const UserProductsScreen(),
            EditProductScreen.routeName: (newContext) =>
                const EditProductScreen(),
            HomePageWidget.routeName: (newContext) => const HomePageWidget(),
            ShopApp.routeName: (newContext) => const ShopApp(),
            LanguageWidget.routeName: (newContext) => const LanguageWidget(),
           
          },
          home: ShopApp(),
        );
      }),
    );
  }
}
