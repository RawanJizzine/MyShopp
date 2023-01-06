// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:app/Providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  const OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}',style: const TextStyle(color: Color.fromARGB(255, 22, 173, 22),  ),),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),style: const TextStyle(color: Color.fromARGB(255, 22, 173, 22),  ),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),
                              ),
                              Text(
                                '${prod.quantity}x \$${prod.price}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
