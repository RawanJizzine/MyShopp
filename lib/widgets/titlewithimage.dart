// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

import '../Providers/products.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    required this.productId,
  }) : super(key: null);

  final String productId;

  Future<int> getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = await prefs.getInt('num') ?? 0;

    return intValue;
  }

  @override
  Widget build(BuildContext context) {
    final translator = GoogleTranslator();

    final productsData = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*  Text(
            productsData.title ?? "",
            style: Theme.of(context).textTheme.headline4?.copyWith(
                color: Colors.white,
                // Color.fromARGB(255, 22, 173, 22),
                fontWeight: FontWeight.bold),
          ) */

          FutureBuilder<int>(
              future: getIntValuesSF(),
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) {
                  // while data is loading:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final indexx = snapshot.data;
                  return Container(
                      child:
                          // data loaded:

                          indexx == 0
                              ? Text(
                                  productsData.title ?? "",
                                  style: const TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                )
                              : FutureBuilder(
                                  future: translator.translate(
                                      "${productsData.title ?? ""}",
                                      from: 'en',
                                      to: 'ar'),
                                  builder: (BuildContext context, snapshot) =>
                                      snapshot.hasData
                                          ? Text(
                                              snapshot.data.toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                height: 1.5,
                                                color: Colors.black,
                                              ),
                                            )
                                          : Text(" ")));
                }
              }),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              /*   RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\$${product.price}",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),  */
              const SizedBox(width: 10),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 300,
                child: Hero(
                  tag: "${productsData.id}",
                  child: Image.network(
                    fit: BoxFit.fill,
                    productsData.imageurl ?? "",
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
