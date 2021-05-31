import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:personalexpenses/util/style_const.dart';
import 'package:personalexpenses/widgets/lists/transaction_list.dart';
import 'package:personalexpenses/widgets/new_transaction.dart';
import './model/transaction.dart';
import 'widgets/chart/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  /* String? strTitle;   // Insted of this use controller
  String? strAmount;*/

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> userTransactionList = [];

  void _addTransaction(String txTitle, double txAmount, DateTime choosenDate) {
/*    final newTx1 = Transaction();
    newTx1.id = "1";
    newTx1.title = "Face wash";
    newTx1.amount = 48;
    newTx1.date = DateTime.now();

    final newTx2 = Transaction();
    newTx2.id = "1";
    newTx2.title = "Face wash";
    newTx2.amount = 48;
    newTx2.date = DateTime.now();*/

    final newTx = Transaction();
    newTx.id = DateTime.now().toString();
    newTx.title = txTitle;
    newTx.amount = txAmount;
    newTx.date = choosenDate;

    setState(() {
      /*  userTransactionList.add(newTx1);
      userTransactionList.add(newTx2);*/
      userTransactionList.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      userTransactionList.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  List<Transaction> get _recentTransactions {
    return userTransactionList.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          style: TextStyle(fontFamily: 'Open Sans'),
        ),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Chart(_recentTransactions),
            ),
            TransactionList(userTransactionList, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
