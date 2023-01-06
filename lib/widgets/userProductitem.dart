// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/products.dart';
import '../screen/editproductscreen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: const Color.fromARGB(255, 22, 173, 22),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              },
              color: const Color.fromARGB(255, 22, 173, 22),
            ),
          ],
        ),
      ),
    );
  }
}
