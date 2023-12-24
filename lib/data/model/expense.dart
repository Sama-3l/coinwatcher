class Expense {
  Expense(
      {required this.expenseName,
      required this.amount,
      required this.date,
      required this.category});

  String expenseName;
  double amount;
  DateTime date;
  String category;

  Map<String, dynamic> toJSON(){
    Map<String, dynamic> map = {
      'name' : expenseName,
      'amount' : amount.toString(),
      'date' : '${date.year}-${date.month}-${date.day}',
      'category' : category
    };
    return map;
  }
}
