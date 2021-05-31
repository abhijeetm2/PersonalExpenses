import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpenses/colors.dart';
import 'package:personalexpenses/model/transaction.dart';
import 'package:personalexpenses/util/style_const.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteFun;

  TransactionList(this.transactions, this.deleteFun);

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    //leading positioned at the beginning of that list tile
                    leading: CircleAvatar(
                      //circular imageview

                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(DateFormat('dd/MM/yyyy')
                        .format(transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: ColorsConst.errorColor,
                      ),
                      onPressed: () {
                        deleteFun!(transactions[index].id);
                      },
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Transaction Added Yet',
                  style: Constant.textHeading,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 25,
                ),
                Container(
                  width: 240,
                  child: Image.asset(
                    'assets/images/sleep.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
  }
}
