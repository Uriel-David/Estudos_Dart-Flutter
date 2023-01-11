// ignore_for_file: avoid_print
import 'package:expenses/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/trasaction.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransaction, {super.key});

  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sumTransaction, currentTransaction) {
      return sumTransaction +
          (double.tryParse(currentTransaction['value'].toString()) ?? 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: transaction['day'].toString(),
                value: double.tryParse(transaction['value'].toString()) ?? 0.0,
                percentage: _weekTotalValue == 0
                    ? 0
                    : (double.tryParse(transaction['value'].toString()) ??
                            0.0) /
                        _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
