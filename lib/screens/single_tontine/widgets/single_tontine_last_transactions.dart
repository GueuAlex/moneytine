import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/screens/single_tontine/widgets/transactions_of_this_tontine.dart';
import 'package:moneytine/widgets/empty_transaction.dart';
import 'package:moneytine/widgets/loading_container.dart';

import '../../../models/money_transaction.dart';
import '../../../models/transation_by_date.dart';
import '../../../remote_services/remote_services.dart';
import '../../../widgets/list_groupe_card_header.dart';
import '../../../widgets/transactions_widget.dart';

class SingleTontineLastTransactions extends StatefulWidget {
  const SingleTontineLastTransactions({
    required this.tontine,
    super.key,
  });

  final Tontine tontine;

  @override
  State<SingleTontineLastTransactions> createState() =>
      _SingleTontineLastTransactionsState();
}

class _SingleTontineLastTransactionsState
    extends State<SingleTontineLastTransactions> {
  ////////////////////////////// all transaction and filter by user id ::///////
  ///
  final List<MoneyTransaction> _allTransactions = [];
  List<DataByDate<MoneyTransaction>> _trasansactionsByDate = [];
  /////////////////////////////////////////////////////////////
  ///
  List<MyUser> members = [];
  ///////////////////////////////////////////////////////
  /// nous permet d'executer getAlltransaction chaque quleque second
  Timer? _timer;
  ///////////////////////////////////////////////////////
  ///nous permet d'afficher un indicateur de chargement ///////
  ///
  bool isVisible = false;
  //////////////////////////////////
  getAllTransactions() async {
    List<MoneyTransaction> allTransactions =
        await RemoteServices().getTransactionsList();

    if (allTransactions.isNotEmpty) {
      _allTransactions.clear();
      for (MoneyTransaction element in allTransactions) {
        if (element.tontineId == widget.tontine.id) {
          //print('idddd : ${element.userId}\n');

          setState(() {
            _allTransactions.add(element);
          });
        }
        MyUser? member =
            await RemoteServices().getSingleUser(id: element.userId);
        if (member != null) {
          setState(() {
            members.add(member);
          });
          // print(member.fullName);
        }
      }
      _allTransactions.sort(
        (a, b) => a.date.compareTo(b.date),
      );
      // Créer une liste de TransactionsByDate à partir de la liste triée
      List<DataByDate<MoneyTransaction>> transactionsByDate = [];
      for (var t in _allTransactions) {
        DataByDate? last =
            transactionsByDate.isNotEmpty ? transactionsByDate.last : null;
        if (last == null || last.date != t.date) {
          transactionsByDate.add(DataByDate<MoneyTransaction>(
            date: t.date,
            data: [t],
          ));
        } else {
          last.data.add(t);
        }
      }
      setState(() {
        _trasansactionsByDate = transactionsByDate;
      });
    }
    //print(members);
  }

  ////////////////////////////// end filter //////////////////////////////////
  ///
  ///////////////////////////////
  ///
  @override
  void initState() {
    getAllTransactions();
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      getAllTransactions();
    });
    Future.delayed(const Duration(seconds: 5)).then((_) {
      setState(() {
        isVisible = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

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
      child: isVisible
          ? _trasansactionsByDate.isNotEmpty
              ? Column(
                  children: [
                    ListGroupCardHeader(
                      isTransaction: true,
                      text: 'Dernière transactions',
                      icon: CupertinoIcons.arrow_right_arrow_left,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TransactionsOfThisTontine(
                                  transactionsByDate: _trasansactionsByDate,
                                  menbers: members);
                            },
                          ),
                        );
                      },
                    ),
                    Expanded(
                      //flex: 3,
                      child: SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                              children: List.generate(
                            _trasansactionsByDate.length,
                            (index) => TransactionsWidget(
                              trasansactionsByDate:
                                  _trasansactionsByDate[index],
                              //user: members[index],
                            ),
                          )),
                        ),
                      ),
                    )
                  ],
                )
              : const EmptyTransactios()
          : LoadingContainer(),
    );
  }
}
