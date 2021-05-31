import 'package:flutter/material.dart';
import 'package:personalexpenses/model/transaction.dart';

import 'lists/transaction_list.dart';
import 'new_transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //becouse we want to show user input from bottom sheet thats why lifting state up perform
        /*   NewTransaction(_addTransaction),
        TransactionList(userTransactionList),*/
      ],
    );
  }
}
