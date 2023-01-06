

// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last
/*
import 'package:app/Providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



 class CartItem extends StatelessWidget {
  final String id;
  final  String  productId;
  final double price;
  final int quantity;
  final String title;
  

  const CartItem(
    this.id,
    this.productId ,
    this.price,
    this.quantity,
    this.title,
  );
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.white,
        child: const Icon(
          Icons.delete,
          color: Color.fromARGB(255, 22, 173, 22),
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text(
                  'Do you want to remove the item from the cart?',
                ),
                actions: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                  ),
                ],
              ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId     );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$$price',style: const TextStyle(color:Color.fromARGB(255, 22, 173, 22) ),),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}',style: const TextStyle(color:Color.fromARGB(255, 22, 173, 22) )),
            trailing: Text('$quantity x' ,style: const TextStyle(color:Color.fromARGB(255, 22, 173, 22) )),
          ),
        ),
      ),
    );
  }
}
*/