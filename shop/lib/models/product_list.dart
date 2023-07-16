import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/constants.dart';

class ProductList with ChangeNotifier {
  final String token;
  final String userId;
  List<Product>? items = [];

  ProductList([this.token = '', this.userId = '', this.items]);

  List<Product> get itemsList => [...items!];
  List<Product> get favoriteItems =>
      items!.where((product) => product.isFavorite).toList();

  Future<void> loadProducts() async {
    items!.clear();
    final response = await http
        .get(Uri.parse('${Constants.productBaseUrl}.json?auth=$token'));

    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse('${Constants.userFavoritesUrl}/$userId.json?auth=$token'),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;

      items!.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Constants.productBaseUrl}.json?auth=$token'),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
      }),
    );

    final id = jsonDecode(response.body)['name'];
    items!.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> updateProduct(Product product) async {
    int index = items!.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json?auth=$token'),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );

      items![index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = items!.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = items![index];
      items!.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json?auth=$token'),
      );

      if (response.statusCode >= 400) {
        items!.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Unable to delete the item at this time.',
          statusCode: response.statusCode,
        );
      }
    }
  }

  int get itemsCount {
    return items!.length;
  }

  /* bool _showFavoriteOnly = false;

  List<Product> get items {
    if (_showFavoriteOnly) {
      return items.where((product) => product.isFavorite).toList();
    }

    return [...items];
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  } */
}
