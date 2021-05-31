import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double? spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //this fix chart bar height issue
          height: 20,
          child:
              FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
        ),
        // FittedBox widget forces its child in to avilable space
        //toStringAsFixed() for fix no decimal value
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            //stack widget which allows you to place widget top of each other like frame layout in android
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label)
      ],
    );
  }
}
