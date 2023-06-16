import 'package:flutter/material.dart';

import '../../models/money_transaction.dart';
import '../../models/transation_by_date.dart';
import '../../models/user.dart';
import '../../style/palette.dart';
import '../../widgets/transactions_widget.dart';

class AllTransactionsHistory extends StatelessWidget {
  const AllTransactionsHistory({
    super.key,
    required this.trasansactionsByDate,
    required this.user,
  });
  final MyUser user;

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
                  user: user,
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
