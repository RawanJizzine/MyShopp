// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:app/widgets/description.dart';
import 'package:flutter/material.dart';

import '../widgets/addtocart.dart';
import '../widgets/colorsandsize.dart';
import '../widgets/counterwithfavbtn.dart';
import '../widgets/titlewithimage.dart';
import 'cartscreen.dart';

class Details extends StatelessWidget {
  final String value;
  const Details({super.key, required this.value});

  static const String routeName = '/set';

  @override
  Widget build(BuildContext context) {
    // is the id!
    /* final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId); */

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 173, 22),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 22, 173, 22),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          //SvgPicture.asset("assets/icons/back.svg"),
        ),
        actions: <Widget>[
          IconButton(
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    //       color: Color.fromARGB(255, 22, 173, 22),
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: 20,
                      right: 20,
                    ),
                    // height: 500,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 148, 248, 128),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        ColorAndSize(productId: value),
                        const SizedBox(height: 20 / 2),
                        Description(productId: value

                            /*   product: Product(
                              id: product.id,
                              imageurl: product.imageurl,
                              title: product.title,
                              price: product.price,
                              description: product.description,
                              quantity: product.quantity), */

                            ),
                        const SizedBox(height: 20 / 2),
                        CounterWithFavBtn(productId: value),
                        const SizedBox(height: 20 / 2),
                        AddToCart(productId: value)
                      ],
                    ),
                  ),
                  ProductTitleWithImage(productId: value)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
