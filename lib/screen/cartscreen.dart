import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/cart.dart';
import '../Providers/orders.dart';
import 'package:relative_scale/relative_scale.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);
  static const routeName = '/carttwo';
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String prodiddd = '';
  int quan = 0;
  int pricee = 0;
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 22, 173, 22),
            automaticallyImplyLeading: true,
            title: Align(
              alignment: AlignmentDirectional(0, -0.3),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 70, 2),
                child: Text(
                  'Shoping Cart',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        // fontFamily: 'Poppins',
                        color: Color(0xFFF5FCFF),
                        fontSize: sy(20),
                      ),
                ),
              ),
            ),
            actions: [],
            centerTitle: false,
            toolbarHeight: 35,
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //390
                        width: sx(510),
                        height: sx(560),
                        decoration: BoxDecoration(),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: cart.items.length,
                            itemBuilder: (context, index) {
                              quan = cart.items.values.toList()[index].quantity;
                              pricee = cart.items.values.toList()[index].price;
                              prodiddd =
                                  cart.items.keys.toList()[index].toString();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image.network(
                                        cart.items.values
                                            .toList()[index]
                                            .imageurl,
                                        width: sx(90),
                                        height: sx(70),
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 55, 5),
                                              child: Text(
                                                cart.items.values
                                                    .toList()[index]
                                                    .title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontSize: sy(15),
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 70, 2),
                                              child: Text(
                                                ' ${cart.items.values.toList()[index].quantity.toString()} x',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontSize: sy(13),
                                                      fontWeight:
                                                          FontWeight.w100,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${cart.items.values.toList()[index].price.toString()} \$',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: sy(16),
                                            ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  50, 0, 0, 0),
                                          child: Consumer<Cart>(
                                            builder: (ctx, orderData, child) =>
                                                IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                setState(() {
                                                  orderData
                                                      .removeItem(prodiddd);
                                                });
                                              },
                                              color: const Color.fromARGB(
                                                  255, 22, 173, 22),
                                            ),
                                          ),
                                        ),

                                        /*     RaisedButton(
                                              padding: const EdgeInsets.all(4.0),
                                              color: Colors.white,
                                              child: Icon(Icons.delete_sharp,
                                                  color: Color.fromARGB(
                                                      255, 22, 173, 22),
                                                  size: 20.0),
                                              onPressed: () {
                                                cart.removeSingleItem(cart
                                                    .items.keys
                                                    .toList()[index]
                                                    ); 
                                              }, 
                                            ), */

                                        /*     IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                color: Colors.green,
                                              ),
                                              onPressed: () => {
                                                Provider.of<Cart>(context,
                                                        listen: false)
                                                    .removeSingleItem(
                                                  cart.items.keys.toList()[index],
                                                )
                                              },
                                            ), */
                                      ),
                                    ],
                                  ),
                                  Divider()
                                ],
                              );
                            }),
                      ),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                            Align(
                              alignment: AlignmentDirectional(0.05, 0.05),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.45, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 8, 0, 0),
                                        child: Text(
                                          'Total Price',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          200, 0, 0, 0),
                                      child: Text(
                                        ' \$${cart.totalAmount}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                                child: RaisedButton(
                                  child: _isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text('ORDER NOW'),
                                  color: Color.fromARGB(255, 22, 173, 22),
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(8.0),
                                  //   splashColor: Colors.grey,
                                  onPressed:
                                      (cart.totalAmount <= 0 || _isLoading)
                                          ? null
                                          : () async {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              await Provider.of<Orders>(context,
                                                      listen: false)
                                                  .addOrder(
                                                cart.items.values.toList(),
                                                cart.totalAmount,
                                              );
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              cart.clear();
                                            },
                                )),
                          ])),
                    ]),
              ),
            ),
          ));
    });
  }
}
