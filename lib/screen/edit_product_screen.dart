// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shop_app_scratch/provider/product.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_scratch/provider/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'EditProductScreen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  GlobalKey<FormState> _fromKey = GlobalKey();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusedNode = FocusNode();
  final _priceFocusedNode = FocusNode();
  final _descriptionFocusedNode = FocusNode();

  var isLoading = false;
  var inIt = true;
  @override
  void dispose() {
    _imageUrlFocusedNode.dispose();
    _priceFocusedNode.dispose();
    _descriptionFocusedNode.dispose();
    _imageUrlController.dispose();

    super.dispose();
  }

  var _exitingProduct = Product(
    id: null,
    price: 0,
    description: '',
    imageUrl: '',
    title: '',
  );

  Map<String, dynamic> initialValue = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  @override
  void didChangeDependencies() {
    if (inIt) {
      final routeArgument =
          ModalRoute.of(context)!.settings.arguments as String?;
      if (routeArgument != null) {
        _exitingProduct =
            Provider.of<Products>(context).findById(routeArgument);
        initialValue = {
          'title': _exitingProduct.title,
          'price': _exitingProduct.price,
          'description': _exitingProduct.description,
          'imageUrl': '',
        };
        _imageUrlController.text = _exitingProduct.imageUrl!;
        print(initialValue);
      }
    }
    inIt = false;
    super.didChangeDependencies();
  }

  Future<void> _submit() async {
    _fromKey.currentState!.validate();
    _fromKey.currentState!.save();
    try {
      if (_exitingProduct != null) {
        await Provider.of<Products>(context, listen: false)
            .updateProducts(_exitingProduct.id!, _exitingProduct);
      } else {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_exitingProduct);
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: deviceSize.width * 0.85,
          height: deviceSize.height * 0.80,
          child: Card(
            elevation: 8,
            child: Container(
              color: Colors.red,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              height: deviceSize.height * 0.80,
              width: deviceSize.width,
              child: Form(
                  key: _fromKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          initialValue: initialValue['title'],
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusedNode);
                          },
                          decoration: InputDecoration(
                            label: Text('Title'),
                          ),
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            _exitingProduct = Product(
                                id: _exitingProduct.id,
                                price: _exitingProduct.price,
                                description: _exitingProduct.description,
                                imageUrl: _exitingProduct.imageUrl,
                                title: value);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          initialValue: initialValue['price'].toString(),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusedNode);
                          },
                          focusNode: _priceFocusedNode,
                          decoration: InputDecoration(
                            label: Text('Price'),
                          ),
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            _exitingProduct = Product(
                                id: _exitingProduct.id,
                                price: double.parse(value.toString()),
                                description: _exitingProduct.description,
                                imageUrl: _exitingProduct.imageUrl,
                                title: _exitingProduct.title);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          initialValue: initialValue['description'],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_imageUrlFocusedNode);
                          },
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          focusNode: _descriptionFocusedNode,
                          decoration: InputDecoration(
                            label: Text('Description'),
                          ),
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            _exitingProduct = Product(
                                id: _exitingProduct.id,
                                price: _exitingProduct.price,
                                description: value,
                                imageUrl: _exitingProduct.imageUrl,
                                title: _exitingProduct.title);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(border: Border.all(width: 2)),
                              height: 100,
                              width: 100,
                              child: _imageUrlController.text.isEmpty
                                  ? Center(child: Text('Enter Image Url'))
                                  : Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_descriptionFocusedNode);
                                },
                                textInputAction: TextInputAction.done,
                                focusNode: _imageUrlFocusedNode,
                                controller: _imageUrlController,
                                decoration: InputDecoration(
                                  label: Text('Imagle Url'),
                                ),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {
                                  _exitingProduct = Product(
                                      id: _exitingProduct.id,
                                      price: _exitingProduct.price,
                                      description: _exitingProduct.description,
                                      imageUrl: value,
                                      title: _exitingProduct.title);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _submit();
                              Navigator.of(context).pop();
                            },
                            child: Text('Submit'))
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
