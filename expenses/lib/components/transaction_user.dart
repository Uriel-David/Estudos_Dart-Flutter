// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';
import '../models/trasaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _trasactions = [
    Transaction(
      id: 't1',
      title: 'New Tennis',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Electricity Bill',
      value: 110.39,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(_trasactions),
        TransactionForm(),
      ],
    );
  }
}
