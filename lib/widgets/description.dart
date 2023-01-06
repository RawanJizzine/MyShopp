// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app/Providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class Description extends StatelessWidget {
  const Description({
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
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: /* Text(
        product.description?? "",
        style: const TextStyle(height: 1.5,color:Colors.black, ),
      ), */

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
                                    product.description ?? "",
                                    style: const TextStyle(
                                      height: 1.5,
                                      color: Colors.black,
                                    ),
                                  )
                                : FutureBuilder(
                                    future: translator.translate(
                                        "${product.description ?? ""}",
                                        from: 'en',
                                        to: 'ar'),
                                    builder: (BuildContext context, snapshot) =>
                                        snapshot.hasData
                                            ? Text(
                                                snapshot.data.toString(),
                                                style: const TextStyle(
                                                  height: 1.5,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : Text(" ")));
                  }
                }));
  }
}
