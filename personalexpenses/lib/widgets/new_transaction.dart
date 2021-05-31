import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final txtTitleController = TextEditingController();
  DateTime? _selectedDate;

  final txtAmountController = TextEditingController();

  void _submitData() {
    if (txtTitleController.text.isEmpty ||
        double.parse(txtAmountController.text) <= 0 ||
        _selectedDate == null) {
      return;
    }
    widget.addTx(txtTitleController.text,
        double.parse(txtAmountController.text), _selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    void _selectDate(BuildContext context) {
      showDatePicker(
              context: context,
              initialDate: currentDate,
              firstDate: DateTime(2000),
              lastDate: currentDate)
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      });
    }

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: txtTitleController,
              onSubmitted: (_) => _submitData(),
              /*  onChanged: (val) {   //Insted of this user controller
                        strTitle = val;
                      },*/
            ),
            TextField(
              controller: txtAmountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.phone,
              onSubmitted: (_) => _submitData(),
              //onChanged: (val) => strAmount = val,    //Insted of this user controller
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text('Choose Date'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _submitData();
              },
              child: Text('Add Transaction'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
