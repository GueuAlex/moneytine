import 'package:flutter/material.dart';
import 'package:moneytine/models/money_transaction.dart';
import 'package:moneytine/models/transation_by_date.dart';
import 'package:moneytine/style/palette.dart';
import 'package:moneytine/widgets/transactions_widget.dart';

class AllTransactionsHistory extends StatelessWidget {
  const AllTransactionsHistory({
    super.key,
    required this.trasansactionsByDate,
  });

  final List<DataByDate<MoneyTransaction>> trasansactionsByDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: const Text('Historique'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: List.generate(
                2,
                (index) => TransactionsWidget(
                  trasansactionsByDate: trasansactionsByDate[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
