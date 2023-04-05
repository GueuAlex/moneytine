import 'package:flutter/material.dart';
import 'package:moneytine/models/transation_by_date.dart';
import 'package:moneytine/style/palette.dart';
import 'package:moneytine/widgets/transactions_widget.dart';

import '../../../models/user.dart';

class TransactionsOfThisTontine extends StatelessWidget {
  const TransactionsOfThisTontine({
    super.key,
    required this.transactionsByDate,
    required this.menbers,
  });
  final List<TransactionsByDate> transactionsByDate;
  final List<User> menbers;

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
                transactionsByDate.length,
                (index) => TransactionsWidget(
                  trasansactionsByDate: transactionsByDate[index],
                  // user: menbers[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
