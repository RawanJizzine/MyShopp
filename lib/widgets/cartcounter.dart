// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api, override_on_non_overriding_member

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/cart.dart';

class CartCounter extends StatefulWidget {
  static const routeName = '/edit-product';
  final String productId;
  const CartCounter({Key? key, required this.productId}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int quantity = 1;

  // final Future<SharedPreferences> prefss = SharedPreferences.getInstance();

  Future<void> _addQuantity(BuildContext context) async {
    // final SharedPreferences prefs = await prefss;
    setState(() {
      quantity++;
     Provider.of<Cart>(context, listen: false).setquantity(quantity);
      //prefs.setInt('productId', quantity);
      /* SharedPreferences prefs =  SharedPreferences.getInstance();  */
    });
  }

  Future<void> _removeQuantity(BuildContext context) async {
    //final SharedPreferences prefs = await prefss;
    setState(() {
      if (quantity > 0) {
        quantity--;

        Provider.of<Cart>(context, listen: false).setquantity(quantity);
        //  prefs.setInt('productId', quantity);
        /*  SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('quantity', quantity); */
      } else {
        quantity = 0;
        Provider.of<Cart>(context, listen: false).setquantity(quantity);

        // prefs.setInt('productId', quantity);
      }
    });
  }

  @override
  int nbrOfItems = 1;
  Widget build(BuildContext context) {
    

    return Row(children: <Widget>[
      Container(
          margin: const EdgeInsets.only(top: 8.0),
          color: Colors.white,
          child: ButtonTheme(
            height: 16.0,
            minWidth: 10.0,
            child: RaisedButton(
                padding: const EdgeInsets.all(4.0),
                color: Colors.white,
                child: Icon(
                  Icons.remove,
                  color: Color.fromARGB(255, 22, 173, 22),
                  size: 20.0,
                ),
                onPressed: () {
                  _removeQuantity(context);
                }),
          )),
      Container(
          width: 60.0,
          padding: const EdgeInsets.only(left: 1.0, right: 1.0),
          child: Center(
            child: Text(
              quantity.toString(),
            ),
          )),
      Container(
        margin: const EdgeInsets.only(top: 8.0),
        color: Colors.white,
        child: ButtonTheme(
          height: 16.0,
          minWidth: 10.0,
          child: RaisedButton(
            padding: const EdgeInsets.all(4.0),
            color: Colors.white,
            child: Icon(Icons.add,
                color: Color.fromARGB(255, 22, 173, 22), size: 20.0),
            onPressed: () {
              _addQuantity(context);
            },
          ),
        ),
      ),
    ]);
  }
}






/*  buildOutlineButton(
            icon: Icons.remove,
            press: () {
              if (nbrOfItems > 1) {
                setState(() {
                  nbrOfItems--;
                  addIntToSF() async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt('quantity', nbrOfItems);
                  }
                });
              }
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            nbrOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: const Color.fromARGB(255, 22, 173, 22),
                ),
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                nbrOfItems++;
                addIntToSF() async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setInt('quantity', nbrOfItems);
                }
                /*   numOfItems = nbrOfItems as TextEditingController;
                controller:
                numOfItems; */
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton(
      {required IconData icon, required Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        onPressed: press(),
        child: Icon(icon),
      ),
    ); 
  } */
