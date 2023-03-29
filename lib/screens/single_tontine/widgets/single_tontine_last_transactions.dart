import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/list_groupe_card_header.dart';
import '../../../widgets/transactions_widget.dart';
import '../../my_tontines/mes_tontines.dart';

class SingleTontineLastTransactions extends StatelessWidget {
  const SingleTontineLastTransactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 2.0),
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
        // bottom: 20.0,
      ),
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 3), // déplace l'ombre vers le bas
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 3), // déplace l'ombre vers le bas
            ),
          ],
          color: Colors.white),
      child: Column(
        children: [
          ListGroupCardHeader(
            isTransaction: true,
            text: 'Dernière transactions',
            icon: CupertinoIcons.arrow_right_arrow_left,
            onTap: () {},
          ),
          Expanded(
            //flex: 3,
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [TransactionsWidget()]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
