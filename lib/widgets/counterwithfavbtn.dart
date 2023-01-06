// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:app/widgets/cartcounter.dart';
import 'package:provider/provider.dart';
import 'package:favorite_button/favorite_button.dart';
import '../Providers/auth.dart';
import '../Providers/pppp.dart';
import '../Providers/products.dart';

class CounterWithFavBtn extends StatefulWidget {
  const CounterWithFavBtn({
    Key? key,
    required this.productId,
  }) : super(key: null);

  final String productId;

  @override
  _CounterWithFavBtnState createState() => _CounterWithFavBtnState();
}

class _CounterWithFavBtnState extends State<CounterWithFavBtn> {
  @override
  bool toggle = false;

  Widget build(BuildContext context) {
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).findById(widget.productId);
    final authData = Provider.of<Auth>(context, listen: false);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: CartCounter(
            productId: '${widget.productId}',
          ),
        ),

        /* Container(
          //  margin: const EdgeInsets.only(top: 8.0),

          padding: const EdgeInsets.all(8),
          //  height: 20,
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            shape: BoxShape.circle,
          ),
          child: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isFavorite == null
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              color: Colors.blue,
              onPressed: () {
                product.toggleFavoriteStatus(
                    /* authData.token,
                        authData.userId, */
                    );
              },
            ),
          ),
        ), */

        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
            child: IconButton(
                icon: product.isFavorite
                    ? Icon(
                        Icons.favorite,
                      )
                    : Icon(Icons.favorite_border),
                color: Color.fromARGB(255, 22, 173, 22),
                onPressed: () {
                  setState(() {
                    // Here we changing the icon.
                    //   toggle = !toggle
                    //;
                    product.toggleFavoriteStatus(
                        authData.token, authData.userId);



                  });
                }),
          ),
        ),
      ],
    );
  }
}
 /*    Expanded(
          child: IconButton(
          icon: toggle
              ? Icon(Icons.favorite_border)
              : Icon(
                  Icons.favorite,
                ),
              color: Colors.red,  
          onPressed: () {
            setState(() {
              // Here we changing the icon.
              toggle = !toggle;
              product.toggleFavoriteStatus();
            });
          } ),) */