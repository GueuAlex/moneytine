import 'package:flutter/material.dart';
import 'package:moneytine/models/money_transaction.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/transation_by_date.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/remote_services/remote_services.dart';
import 'package:moneytine/style/palette.dart';

import '../../../widgets/transactions_widget.dart';

class GroupUserContribution extends StatefulWidget {
  const GroupUserContribution({
    super.key,
    required this.groupe,
    required this.tontine,
    required this.user,
  });
  final Groupe groupe;
  final Tontine tontine;
  final User user;

  @override
  State<GroupUserContribution> createState() => _GroupUserContributionState();
}

class _GroupUserContributionState extends State<GroupUserContribution> {
/////////////////////// all transactions list ///////////////////
  ///
  final List<MoneyTransaction> _allTransactions = [];
  List<TransactionsByDate> _trasansactionsByDate = [];

  getAllTransactions() async {
    List<MoneyTransaction> allTransactions =
        await RemoteServices().getTransactionsList();

    if (allTransactions.isNotEmpty) {
      _allTransactions.clear();
      for (MoneyTransaction element in allTransactions) {
        if (element.userId == widget.user.id &&
            element.groupeId == widget.groupe.id) {
          setState(() {
            _allTransactions.add(element);
          });
        }
      }
      _allTransactions.sort(
        (a, b) => a.date.compareTo(b.date),
      );
      // Créer une liste de TransactionsByDate à partir de la liste triée
      List<TransactionsByDate> transactionsByDate = [];
      for (var t in _allTransactions) {
        TransactionsByDate? last =
            transactionsByDate.isNotEmpty ? transactionsByDate.last : null;
        if (last == null || last.date != t.date) {
          transactionsByDate.add(TransactionsByDate(
            date: t.date,
            mTransaction: [t],
          ));
        } else {
          last.mTransaction.add(t);
        }
      }
      setState(() {
        _trasansactionsByDate = transactionsByDate;
      });
    }
  }

  @override
  void initState() {
    getAllTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: Text(widget.user.fullName),
      ),
      body: SafeArea(
        child: _allTransactions.isEmpty
            ? const Center(
                child: Text(
                  'Aucune transaction trouvée pour ce membre',
                  textAlign: TextAlign.center,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    // right: 8.0,
                    left: 8.0,
                  ),
                  child: Column(
                    children: List.generate(
                      _trasansactionsByDate.length,
                      (index) => TransactionsWidget(
                        trasansactionsByDate: _trasansactionsByDate[index],
                        //user: widget.user,
                        //groupe: widget.groupe,
                        //tontine: widget.tontine,
                      ),
                      //(index) => Container(),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
