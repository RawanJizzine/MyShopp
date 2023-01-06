// ignore_for_file: unused_import, unnecessary_import, library_private_types_in_public_api, non_constant_identifier_names, unnecessary_null_comparison, unnecessary_cast, unused_local_variable, use_build_context_synchronously, depend_on_referenced_packages, deprecated_member_use
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import 'package:app/Providers/pppp.dart';

import '../Providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  bool light = false;
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Product _editedProduct = Product(
    title: '',
    price: 0,
    description: '',
    imageurl: '',
    isFruits: false, //false
    id: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': 0,
    'imageUrl': '',
    'isFruits': false,
  };
  var _isInit = true;
  var _isLoading = false;
  bool isNew = true;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      //equal 0
      // ignore: unnecessary_nullable_for_final_variable_declarations
      //String?
      /*   final String productId =
          ModalRoute.of(context)?.settings.arguments == null
              ? ''
              : ModalRoute.of(context)!.settings.arguments as String; */

      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        isNew = false;
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findById(productId.toString());
        _initValues = {
          'title': _editedProduct.title ?? "",
          'description': _editedProduct.description ?? "",
          'price': _editedProduct.price.toString(),
          'isFruits': _editedProduct.isFruits.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageurl ?? "";
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

/*  Future<void> _saveForm(BuildContext context) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occurred!'),
            content: const Text('Something went wrong.'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  } */

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (isNew) {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id ?? "", _editedProduct);
    }

    // if (_editedProduct.id != null) {
    /*if (isNew) {

      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id ?? "", _editedProduct);
    } else {
      try {
      await  Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occurred!'),
            content: const Text('Something went wrong.'),
            actions: <Widget>[
               FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
            
              ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    } */
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //final product = Provider.of<Product>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () => {
                    _saveForm(),
                  }),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(children: <Widget>[
                  TextFormField(
                    initialValue: _initValues['title'].toString(),
                    decoration: const InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                        title: value!,
                        price: _editedProduct.price ?? 0,
                        description: _editedProduct.description ?? "",
                        imageurl: _editedProduct.imageurl ?? "",
                        id: _editedProduct.id ?? "",
                        isFruits: _editedProduct.isFruits,
                        isFavorite: _editedProduct.isFavorite /*?? false */,
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['price'].toString(),
                    decoration: const InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a price.';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number.';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Please enter a number greater than zero.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                        title: _editedProduct.title ?? "",
                        price: int.parse(value!),
                        description: _editedProduct.description ?? "",
                        imageurl: _editedProduct.imageurl ?? "",
                        id: _editedProduct.id ?? "",
                        isFruits: _editedProduct.isFruits, //?? false
                        isFavorite: _editedProduct.isFavorite /*?? false */,
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['description'].toString(),
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description.';
                      }
                      if (value.length < 10) {
                        return 'Should be at least 10 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                        title: _editedProduct.title ?? "",
                        price: _editedProduct.price ?? 0,
                        description: value!,
                        imageurl: _editedProduct.imageurl ?? "",
                        id: _editedProduct.id ?? "",
                        isFruits: _editedProduct.isFruits,
                        isFavorite: _editedProduct.isFavorite /*?? false*/,
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(
                          top: 8,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? const Text('Enter a URL')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          onFieldSubmitted: (_) {
                            // _saveForm();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an image URL.';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL.';
                            }

                            if (!value.endsWith('.png') &&
                                !value.endsWith('.jpg') &&
                                !value.endsWith('.jpeg')) {
                              return 'Please enter a valid image URL.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                              title: _editedProduct.title ?? "",
                              price: _editedProduct.price ?? 0,
                              description: _editedProduct.description ?? "",
                              imageurl: value!,
                              id: _editedProduct.id ?? "",
                              isFavorite: _editedProduct.isFavorite,
                              isFruits: _editedProduct.isFruits,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      const Text("vegetables"),
                      Switch(
                        // This bool value toggles the switch.
                        value: _editedProduct.isFruits,
                        activeColor: Colors.red,
                        onChanged: (value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            _editedProduct = Product(
                              title: _editedProduct.title ?? "",
                              price: _editedProduct.price ?? 0,
                              description: _editedProduct.description ?? "",
                              imageurl: _editedProduct.imageurl ?? "",
                              id: _editedProduct.id ?? "",
                              isFavorite:
                                  _editedProduct.isFavorite /*?? false */,
                              isFruits: value,
                            );

                           
                          });
                        },
                      ),
                      /*    FlutterSwitch(
                    activeToggleColor: Colors.red,
                    inactiveToggleColor: Colors.black,
          
                    showOnOff: false,
                    //  activeTextColor: Colors.black,
                    // inactiveTextColor: const Color.fromARGB(255, 22, 173, 22),
                    value: _initValues['isFruits'] as bool,
                    onToggle: (val) {
                      setState(() {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageurl: _editedProduct.imageurl,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          isFruits: val,
                        );
          
                        //  _saveForm();
                      });
                    },
                  ), */
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "Fruits",
                        ),
                      ),
                    ],
                  )
                ]),
              )),
    );
  }
}
