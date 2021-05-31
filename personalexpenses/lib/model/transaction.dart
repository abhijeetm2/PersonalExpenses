class Transaction {
  late String _id;
  late String _title;
  late double _amount;
  late DateTime _date;

  /*Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});*/

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  double get amount => _amount;

  set amount(double value) {
    _amount = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
