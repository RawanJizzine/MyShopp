// ignore_for_file: override_on_non_overriding_member, unused_local_variable, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'package:app/Providers/pppp.dart';
import 'package:app/widgets/Drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import '../Providers/products.dart';
import 'package:app/screen/cartscreen.dart';
//import '../widgets/itemcard.dart';
//import 'cartscreen.dart';

import '../translations/localkeys.dart';
import 'detailsscreen.dart';

class Myhome extends StatefulWidget {
  const Myhome({Key? key}) : super(key: key);

  @override
  static const routeName = '/home';

  @override
  MyhomeState createState() => MyhomeState();
}

class MyhomeState extends State<Myhome> with TickerProviderStateMixin {
  var _isInit = true;
  var _isLoading = false;
  var c;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      // BuildContext  context = ctx;
      // ignore: dead_code

      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
          // addIntToSF();
        });
      });

      _isInit = false;
      super.didChangeDependencies();
    }

    // var scafold = Scaffold.of(context);
  }

  Future<int> getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = await prefs.getInt('num') ?? 0;

    return intValue;
  }

  @override
  Widget build(BuildContext context) {
    print(getIntValuesSF());
    // Provider.of<Products>(context, listen: false).getfav();
    TabController _tabController = TabController(length: 3, vsync: this);
    //final productsData = Provider.of<Products>(context);
    //final productData = Provider.of<Product>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 22, 173, 22),
          elevation: 0,
          leading: IconButton(
            color: Colors.white,
            onPressed: () => {
              //on drawer menu pressed

              Navigator.of(context).pushNamed(AppDrawer.routeName),
              //if drawer is closed then open the drawer.
            },
            icon: const Icon(Icons.menu),
          ),

          /*  IconButton(
          color: Color.fromARGB(255, 22, 173, 22),
         icon: const Icon(Icons.arrow_back),
         onPressed: () => Navigator.of(context).pop(),
        //SvgPicture.asset("assets/icons/back.svg"),
        ), */
          actions: <Widget>[
            IconButton(
              color: Colors.white,
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(HomePageWidget.routeName);
              },
            ),
            const SizedBox(width: 20.0 / 2)
          ],
        ),
        drawer: const AppDrawer(),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                //   mainAxisAlignment:MainAxisAlignment.spaceBetween,
                //    mainAxisSize: MainAxisSize.max,

                ///
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: LocaleKeys.tit.tr() == "Fruits and Vegetables"
                              ? Text(
                                  LocaleKeys.tit.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontWeight: FontWeight.bold),
                                )
                              : Container(
                                    padding: const EdgeInsetsDirectional.fromSTEB( 190, 0, 0, 0),
                                  child: Text(
                                  LocaleKeys.tit.tr(),
                                 
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontWeight: FontWeight.bold),
                                )),

                          /* Text(
                            LocaleKeys.tit.tr()=="Fruits and Vegetables"?LocaleKeys.tit.tr():,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold),
                          ), */
                        ),
                      ),
                    ),
                    //     const SizedBox(
                    //    height: 1,
                    //  ),
                    Container(
                      //  alignment: Alignment.topLeft,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: TabBar(
                            isScrollable: true,
                            controller: _tabController,
                            labelPadding:
                                const EdgeInsets.only(left: 30, right: 30),
                            labelColor: const Color.fromARGB(255, 22, 173, 22),
                            unselectedLabelColor: Colors.grey,
                            indicatorColor:
                                const Color.fromARGB(255, 22, 173, 22),
                            tabs: [
                              Tab(
                                text: LocaleKeys.NOAA_FAWAKEH.tr(),
                              ),
                              Tab(
                                text: LocaleKeys.NOAA_KHODAR.tr(),
                              ),
                              Tab(
                                text: LocaleKeys.l_all.tr(),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      // flex: ,
                      child: SizedBox(
                        height: double.maxFinite,
                        child:
                            TabBarView(controller: _tabController, children: [
                          // ignore: prefer_const_constructors
                          buildd(
                              items: Provider.of<Products>(context).fruits,
                              ctx: context,
                              gett: getIntValuesSF()),
                          buildd(
                              items: Provider.of<Products>(context).Vegetables,
                              ctx: context,
                              gett: getIntValuesSF()),
                          buildd(
                              items: Provider.of<Products>(context).all,
                              ctx: context,
                              gett: getIntValuesSF()),
                        ]),
                      ),
                    )
                  ]),

        //       CategoryList();
      ),
    );
  }
}

Widget buildd(
    {required List<Product> items,
    required BuildContext ctx,
    required Future<int> gett}) {
  String domain = "https://google.com/";
  final translator = GoogleTranslator();
  var translatetitel;
  var translateprice;
  Future<int> hh = gett;
  // final productData = Provider.of<Product>(ctx);
  /* return ListView.separated(
    itemCount: items.length,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    primary: false,
    padding: const EdgeInsets.all(8),
    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
      // builder: (c) => products[i],
      value: items[i],
      child: ItemCard(),
    ),
    separatorBuilder: (ctx, i) => const Divider(
      color: Colors.grey,
    ),
  ); */
  /* ListView.separated(
    //GestureDetector(

    //child:

    padding: EdgeInsets.zero,
    scrollDirection: Axis.vertical,
    itemCount: items.length,
    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
      // builder: (c) => products[i],
      value: items[i],
      child: const ItemCard(),
    ),
    separatorBuilder: (BuildContext context, int index) => const Divider(
      color: Colors.purple,
    ),
  ); */
  return Scaffold(
    body: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
      child: GridView(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 40,
          mainAxisSpacing: 1,
          childAspectRatio: 1,
        ),
        scrollDirection: Axis.vertical,
        children: items
            .map((e) => Align(
                  alignment: AlignmentDirectional(-0.05, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                    child: Container(
                      width: 180,
                      height: 150,
                      decoration: BoxDecoration(
                          //  color: Color.fromARGB(255, 175, 236, 142),
                          ),
                      child: InkWell(
                        onTap: () {
                          //  print(e.imageurl);
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Details(value: e.id.toString()),
                          );
                          Navigator.of(ctx).push(route);
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              //    borderRadius: BorderRadius.circular(20),
                              ClipRect(
                                child: Image.network(
                                  e.imageurl ?? "",
                                  width: 200,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              ),

                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 20, 0),
                                  child: /* Text(
                                  gett == 0
                                      ? e.title ?? ""
                                      : translatetitel = translator
                                          .translate("${e.title ?? ""}",
                                              from: 'en', to: 'ar')
                                          .toString(),
                                  style: Theme.of(ctx)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ), */
                                      FutureBuilder<int>(
                                          future: gett,
                                          builder:
                                              (BuildContext context, snapshot) {
                                            if (!snapshot.hasData) {
                                              // while data is loading:
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else {
                                              final indexx = snapshot.data;
                                              return Container(
                                                  child:
                                                      // data loaded:

                                                      indexx == 0
                                                          ? Text(e.title ?? "",
                                                              style: Theme.of(ctx)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900))
                                                          : FutureBuilder(
                                                              future: translator.translate(
                                                                  "${e.title ?? ""}",
                                                                  from: 'en',
                                                                  to: 'ar'),
                                                              builder: (BuildContext
                                                                          context,
                                                                      snapshot) =>
                                                                  snapshot.hasData
                                                                      ? Text(snapshot
                                                                          .data
                                                                          .toString(),
                                                                          
                                                                          style: Theme.of(ctx)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900)
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          )
                                                                      : Text("")));
                                            }
                                          })),

                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 20, 0),
                                child: Text(
                                  '${e.price}\$',
                                  style: Theme.of(ctx)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    ),
  );
}
