// ignore_for_file: equal_keys_in_map

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utils/constants.dart';

class OrderList with ChangeNotifier {
  final String token;
  final String userId;
  List<Order>? items = [];

  OrderList([this.token = '', this.userId = '', this.items]);

  List<Order> get itemsValue {
    return [...items!];
  }

  int get itemsCount {
    return items!.length;
  }

  Future<void> loadOrders() async {
    items!.clear();
    List<Order> itemsUser = [];

    final response = await http
        .get(Uri.parse('${Constants.orderBaseUrl}/$userId.json?auth=$token'));

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((ordertId, orderData) {
      itemsUser.add(
        Order(
          id: ordertId,
          date: DateTime.parse(orderData['date']),
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              productId: item['productId'],
              name: item['name'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
        ),
      );
    });

    items = itemsUser.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    if (cart.items.values.isEmpty) return;

    final dateNow = DateTime.now();

    final response = await http.post(
      Uri.parse('${Constants.orderBaseUrl}/$userId.json?auth=$token'),
      body: jsonEncode({
        "total": cart.totalAmount,
        "products": cart.items.values.toList(),
        "date": dateNow.toIso8601String(),
        "products": cart.items.values
            .map((cartItem) => {
                  "id": cartItem.id,
                  "productId": cartItem.productId,
                  "name": cartItem.name,
                  "quantity": cartItem.quantity,
                  "price": cartItem.price,
                })
            .toList(),
      }),
    );

    items!.insert(
      0,
      Order(
        id: jsonDecode(response.body)['name'],
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: dateNow,
      ),
    );
    notifyListeners();
  }
}
