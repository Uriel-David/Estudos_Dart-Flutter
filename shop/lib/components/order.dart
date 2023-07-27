import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final itemsHeight = (widget.order.products.length * 25.0) + 10;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded ? itemsHeight + 80 : 80,
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$ ${widget.order.total.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _expanded ? itemsHeight : 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                child: ListView(
                  children: widget.order.products.map((product) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${product.quantity}x \$ ${product.price}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
