import 'dart:convert';

//import 'package:app/Providers/auth.dart';
import 'package:app/Providers/pppp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models.dart/http_exception.dart';

class Products with ChangeNotifier {
  String authToken = '';
  final String userId;

  Products(this.authToken, this.userId, this._items);

//String? authToken;
  /* void update(authToken, items) {
    _items = items;
    authToken = authToken;
    print(authToken);
    notifyListeners();
  } */
  List<Product> g = [];
  List<String> allfavid = [];
  List<Product> _items = [
    /* Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageurl: 'https://www8.0zz0.com/2022/10/16/10/248758635.jpeg',
      isFruits: true,
    ),
    Product(
      id: 'p1',
      title: 'hhhhh',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageurl: 'https://www8.0zz0.com/2022/10/16/10/248758635.jpeg',
      isFruits: true,
    ), */
  ];
  // ignore: prefer_typing_uninitialized_variables
  var numberofitems;
  int selectedindex = 0;
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  

  void addselectedindex(int i) {
    selectedindex = i;
    notifyListeners();
  }

  /*void numOfItemss(int num, int pro) {
     numberofitems = num;
    var indexitem = pro;
  } */
  /* int  findnumofitem(String id,int numofitems) {
    return _items.firstWhere((prod) => prod.id == id);
  } */

  /* int get getnumofitemss {
    return numberofitems;
  } */

  List<Product> get selectind {
    if (selectedindex == 0) {
      return _items.where((prodItem) => prodItem.isFruits == true).toList();
    } else if (selectedindex == 1) {
      return _items.where((prodItem) => prodItem.isFruits == false).toList();
    } else {
      return _items.where((prodItem) => prodItem.isFavorite == true).toList();
    }
  }

  /* List<Product> get FAVV {
     notifyListeners();
    for (var IDD in allfavid) {
      for (var item in _items) {
        if (item.id == IDD) {
          g.add(item);
          notifyListeners();
        }
      }
    }
    return g;
  } */

  List<Product> get favoriteItems {
    return _items
        .where((prodItem) =>
            prodItem.isFavorite == null ? false : prodItem.isFavorite == true)
        .toList();
  }
/*
  Future<void> getfav() async {
    //isFavorite = togle;
    notifyListeners();
    final url = Uri.https('flutter-update-8bfba-default-rtdb.firebaseio.com',
        '/userFavorites/$userId.json', {'auth': authToken});
    try {
      var response = await http.get(url);
      if (response.statusCode >= 400) {
        final fav = json.decode(response.body) as Map<String, dynamic>?;
        if (fav == null) {
          return;
        }
        fav.forEach((iD, F) {
          //  allfavid.add(iD);
          //.where((prodItem) =>
          //   prodItem.id == null ? false : prodItem.isFavorite == true)
          // .toList();
          if (allfavid.isNotEmpty) {
            final allfavidExist = allfavid.where((e) => e == iD);
            if (allfavidExist.isEmpty) {
              allfavid.add(iD);
            }
          } else {
            allfavid.add(iD);
          }
        });
      }
      notifyListeners();
    } catch (error) {}
  } */

  List<Product> get fruits {
    return _items.where((prodItem) => prodItem.isFruits == true).toList();
  }

  // ignore: non_constant_identifier_names
  List<Product> get Vegetables {
    return _items.where((prodItem) => prodItem.isFruits == false).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get all {
    return _items;
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
  //https://stackoverflow.com/questions/73633590/flutter-type-internallinkedhashmapstring-dynamic-is-not-a-subtype-of-type
//https://htgithub.com/Roopaish/Flutter-RoadMap/blob/master/lib/shop/providers/products.dart
  // final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
  /*Future<void> fetchProduct() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    await database.ref('products').get().then((snapshot) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      print(values.toString());
      values.forEach((k, v) {
        print(k);
        print(v["title"]);
        Product p = Product(
          id: k,
          imageurl: v['imageurl'],
          title: v['title'],
          price: v['price'],
          description: v['description'],
        );
        _items.add(p);
      });
      notifyListeners();
    });
  } */

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final Map<String, dynamic> filterString = filterByUser
        ? {
            'auth': authToken,
            'orderBy': "\"creatorId\"",
            'equalTo': "\"$userId\"",
          }
        : {'auth': authToken};

    //flutter-update-8bfba-default-rtdb.firebaseio.com
    var url = Uri.https('flutter-update-8bfba-default-rtdb.firebaseio.com',
        '/products.json', filterString);

    // ignore: unnecessary_string_escapes

    try {
      final response = await http.get(url);
      print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      print('hii');

      print(extractedData);
      if (extractedData == null) {
        return;
        // _items=[];
      }

      url = Uri.https('flutter-update-8bfba-default-rtdb.firebaseio.com',
          '/userFavorites/$userId.json', {'auth': authToken});

      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      //as Map<String, dynamic>?;

      //   print(favoriteData);

      // final List<Product> loadedProducts = [];
      //  final List<Product> loadedProducts = [];
      extractedData.forEach((k, v) {
        v.forEach((d, n) {
          final value = favoriteData == null
              ? false
              : favoriteData[k] != null || favoriteData[k] == 'true';
          bool? _isFavorite = value;

          print(k);
          print(v);
          print("loiloi");
          Product p = Product(
            id: d,
            imageurl: n['imageurl'],
            title: n['title'],
            price: n['price'],
            description: n['description'],
            isFavorite: _isFavorite,
            isFruits: n['isFruits'],
          );
          print(n['title']);
          // if (!_items.contains(p)) {
          if (_items.isNotEmpty) {
            final itemIsExist = _items.where((e) => e.id == p.id);

            if (itemIsExist.isEmpty) {
              _items.add(p);
            }
          } else {
            _items.add(p);
          }
        });
      });

      // print("Data is not loaded");

      // _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    // final url = Uri.https('flutter-update-8bfba-default-rtdb.firebaseio.com',
    //  '/products/$userId.json', {'auth': authToken});
    final url = Uri.https('flutter-update-8bfba-default-rtdb.firebaseio.com',
        '/products/$userId.json', {'auth': authToken});

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // ignore: prefer_is_empty

        body: json.encode({
          'title': product.title ?? "",
          'creatorId': userId == null ? "" : userId,
          'description': product.description ?? "",
          'imageurl': product.imageurl ?? "",
          'price': product.price ?? 0, //?? 0.0
          'isFavorite': product.isFavorite == null ? false : product.isFavorite,
          'isFruits': product.isFruits == null ? false : product.isFruits,
          //?? false,
        }),
        //.length ??0,
      );
      print(response.statusCode);

      final newProduct = Product(
        title: product.title ?? "",
        description: product.description ?? "",
        price: product.price ?? 0,
        imageurl: product.imageurl ?? "",
        isFruits: product.isFruits == null ? false : product.isFruits,
        id: json.decode(response.body)['name'] ?? "",
      );
      _items.add(newProduct);

      notifyListeners();
      // _items.insert(0, newProduct); // at the start of the list

      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      /* if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        final newProduct = Product(
          title: product.title,
          description: product.description,
          price: product.price,
          imageurl: product.imageurl,
          isFruits: product.isFruits,
          id: json.decode(response.body)['name'],
        );
        _items.add(newProduct);
        // _items.insert(0, newProduct); // at the start of the list
        notifyListeners();
        return Product.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create album.');
      } */
    } catch (error) {
      throw (error);
    }
  }

/*
  Future<Product> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-update-8bfba-default-rtdb.firebaseio.com/products.json'
        );
    await http.post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageurl,
        'price': product.price,
        'isFavorite': product.isFavorite,
        'isFruits': product.isFruits,
      }),
    );
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        isFruits: product.isFruits,
        isFavorite: product.isFavorite,
        imageurl: product.imageurl);
    return newProduct;
  }*/

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      final url = Uri.https('flutter-update-8bfba-default-rtdb.firebaseio.com',
          '/products/$userId/$id.json', {'auth': authToken});
      /*   final url = Uri.https('flutter-update-8bfba-default-rtdb.firebaseio.com',
          '/products/$userId.json?auth=$authToken'); */

      await http.patch(url,
          body: json.encode({
            'title': newProduct.title ?? "",
            'description': newProduct.description ?? "",
            'imageurl': newProduct.imageurl ?? "",
            'price': newProduct.price ?? 0,
            'isFruits': newProduct.isFruits,
            //?? false,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https('flutter-update-8bfba-default-rtdb.firebaseio.com',
        '/products/$userId/$id.json', {'auth': authToken});
    /* final url = Uri.https('flutter-update-8bfba-default-rtdb.firebaseio.com',
        '/products/$id.json?auth=$authToken'); */

    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct == null ? " " : existingProduct;
  }
}
