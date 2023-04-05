import 'package:moneytine/models/money_transaction.dart';

class TransactionsByDate {
  TransactionsByDate({
    required this.date,
    required this.mTransaction,
  });
  final DateTime date;
  final List<MoneyTransaction> mTransaction;
}
