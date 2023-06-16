import 'package:flutter/material.dart';

import '../../../models/money_transaction.dart';
import '../../../models/transation_by_date.dart';
import '../../../models/user.dart';
import '../../../style/palette.dart';
import '../../../widgets/transactions_widget.dart';

class TransactionsOfThisTontine extends StatelessWidget {
  const TransactionsOfThisTontine({
    super.key,
    required this.transactionsByDate,
    required this.menbers,
    required this.user,
  });
  final List<DataByDate<MoneyTransaction>> transactionsByDate;
  final List<MyUser> menbers;
  final MyUser user;

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
                  user: user,
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
