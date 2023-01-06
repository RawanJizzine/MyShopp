// ignore_for_file: unused_import, prefer_const_constructors

import 'package:app/Providers/cart.dart';
import 'package:app/Providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Providers/pppp.dart';

class AddToCart extends StatelessWidget {
  AddToCart({
    required this.productId,
  }) : super(key: null);

  final String productId;

  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    final product = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

//var qua=product.getnumofitemss;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 40,

              // ignore: deprecated_member_use
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Color.fromARGB(255, 22, 173, 22),
                onPressed: () {
                  cart.addItem(productId, product.price ?? 0,
                      product.title ?? "", product.imageurl ?? "");
                },
                child: Text(
                  "Buy  Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
