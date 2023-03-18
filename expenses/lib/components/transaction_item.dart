import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/trasaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onRemove,
  }) : super(key: key);

  final Transaction transaction;
  final void Function(String p1) onRemove;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.black,
  ];

  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();

    int randColor = Random().nextInt(5);
    _backgroundColor = colors[randColor];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget.transaction.value}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.transaction.id),
                icon: const Icon(Icons.delete),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.red),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.onRemove(widget.transaction.id),
              ),
      ),
    );
  }
}
