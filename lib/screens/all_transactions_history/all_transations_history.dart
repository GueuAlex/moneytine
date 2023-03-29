import 'package:flutter/material.dart';
import 'package:moneytine/style/palette.dart';

class AllTransactionsHistory extends StatelessWidget {
  const AllTransactionsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: const Text('Historique'),
      ),
      body: const SafeArea(
          child: Center(
        child: Text('Historique des transactions'),
      )),
    );
  }
}
