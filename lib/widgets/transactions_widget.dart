import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/models/money_transaction.dart';
import 'package:moneytine/models/transation_by_date.dart';

import '../style/palette.dart';
import 'transactions_type_container.dart';

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget({
    super.key,
    required this.trasansactionsByDate,
    //required this.user,
    //required this.groupe,
    //required this.tontine,
  });

  final DataByDate<MoneyTransaction> trasansactionsByDate;
  //final User user;
  //final Groupe groupe;
  //final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    //print('testeseset :: ${user.fullName}\n');
    return Container(
      margin: const EdgeInsets.only(left: 0.0, top: 5.0, bottom: 0.0),
      constraints: const BoxConstraints(
        minHeight: 120,
        //maxWidth: double.infinity,
      ),
      child: Container(
        margin: const EdgeInsets.only(),
        padding: const EdgeInsets.all(
          0.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Palette.whiteColor,
          borderRadius: BorderRadius.circular(
            0.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ////////////////: date dot ///////////
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.appPrimaryColor,
                    ),
                    child: Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    DateFormat('dd').format(trasansactionsByDate.date),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    DateFormat.MMM('fr_FR').format(trasansactionsByDate.date),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            /////////////////////
            Column(
              children: List.generate(
                trasansactionsByDate.data.length,
                (index) => TransactionsTypeContainer(
                  color: trasansactionsByDate.data[index].type == 'Versement'
                      ? Palette.appPrimaryColor
                      : trasansactionsByDate.data[index].type == 'Retrait'
                          ? Palette.secondaryColor
                          : Palette.appSecondaryColor,
                  mTransactions: trasansactionsByDate.data[index],
                  //groupe: groupe,
                  //tontine: tontine,
                  //user: user,
                  lastIndex: trasansactionsByDate.data.length,
                  index: index,
                ),
              ),
            ),
            //////////////////

            /////////////////
            const SizedBox(
              height: 15.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
