import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpenses/model/transaction.dart';
import 'package:personalexpenses/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }

      print("$totalSum  and ${DateFormat.E().format(weekDay).substring(0, 1)}");
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      //fold allow us to calcluate total amount sum previous value and item is current value
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        //added container for padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              // flex: 2,   //its like weight sum in andorid java
              fit: FlexFit.tight,
              child: ChartBar(
                  // if we add largae  value then the chart gets shrink to fix this use flexible wigdet
                  (data['day'].toString()),
                  (data['amount'] as double),
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
