import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/trasaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Not exist expenses register!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final transaction = transactions[index];
              return TransactionItem(
                key: GlobalObjectKey(transaction),
                transaction: transaction,
                onRemove: onRemove,
              );
            },
          );
    /* ListView(
            children: transactions.map((transaction) {
              return TransactionItem(
                key: ValueKey(transaction.id),
                transaction: transaction,
                onRemove: onRemove,
              );
            }).toList(),
          ); */
  }
}
