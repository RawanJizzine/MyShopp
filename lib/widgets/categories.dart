/*import 'package:app/widgets/pagecategories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/products.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  // by default first item will be selected
  int selectedIndex = 0;
  List categories = ['Fruits', 'Vegetables', 'fav'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20 / 2),
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
              // Provider.of<Products>(context).addselectedindex(index);
              /*         if (selectedIndex == 0) {
                CategoriePage(
                  items: Provider.of<Products>(context, listen: false).fruits,
                );
              } else if (selectedIndex == 1) {
                CategoriePage(
                  items:
                      Provider.of<Products>(context, listen: false).Vegetables,
                );
              } else {
                CategoriePage(
                  items:
                      Provider.of<Products>(context, listen: false).Vegetables,
                );
              } */
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: 20,
              // At end item it add extra 20 right  padding
              right: index == categories.length - 1 ? 20 : 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? Colors.white.withOpacity(0.4)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              categories[index],
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
} 
*/
