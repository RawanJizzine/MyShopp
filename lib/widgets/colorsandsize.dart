// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/products.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({
    required this.productId,
  }) : super(key: null);

  final String productId;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color.fromARGB(255, 22, 173, 22),
              ),
              children: [
                //    const TextSpan(text: "Price\n",  ),
                TextSpan(
                  text: "${product.price}\$",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 200,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color.fromARGB(255, 22, 173, 22),
              ),
              children: [
                // TextSpan(text: "Quantity\n"),
                TextSpan(
                  text: "1 kg",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
