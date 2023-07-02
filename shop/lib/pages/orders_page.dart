import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<OrderList>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    // final OrderList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () => _refreshOrders(context),
              child: Consumer<OrderList>(
                builder: (ctx, orders, child) => ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, index) => OrderWidget(
                    order: orders.items[index],
                  ),
                ),
              ),
            );
          }
        },
      ),
      /* body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshOrders(context),
              child: ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (context, index) => OrderWidget(
                  order: orders.items[index],
                ),
              ),
            ), */
    );
  }
}
