import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:moneytine/functions/functions.dart';
import 'package:moneytine/style/palette.dart';

import '../../../models/money_transaction.dart';
import '../../../models/tontine.dart';
import '../../../models/transation_by_date.dart';
import '../../../models/user.dart';
import '../../../widgets/loading_container.dart';
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
  final MyUser user;

  @override
  State<GroupUserContribution> createState() => _GroupUserContributionState();
}

class _GroupUserContributionState extends State<GroupUserContribution> {
  //////////////////////////////////// utilisez pour temporisé pendant que les données chargent////
  ///
  bool isLoading = true;
/////////////////////// all transactions list ///////////////////
  ///
  final List<MoneyTransaction> _allTransactions = [];
  List<DataByDate<MoneyTransaction>> _trasansactionsByDate = [];

  Future<void> getAllTransactions() async {
    /* List<MoneyTransaction> allTransactions =
        await RemoteServices().getTransactionsList(); */

    if (globalTransactionsList.isNotEmpty) {
      _allTransactions.clear();
      for (MoneyTransaction element in globalTransactionsList) {
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
  }

  @override
  void initState() {
    getAllTransactions();
    Future.delayed(const Duration(seconds: 5)).then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return /* Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: Text(widget.user.fullName),
      ),
      body:  */
        SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 15.0),
        //color: Colors.amber,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 1.9,
        child: !isLoading
            ? _allTransactions.isEmpty
                ? const Center(
                    child: Text(
                      'Aucune transaction trouvée pour ce membre',
                      textAlign: TextAlign.center,
                    ),
                  )
                : _allTransactions.length > 3
                    ? LiquidPullToRefresh(
                        backgroundColor: Palette.secondaryColor,
                        color: Palette.whiteColor,
                        onRefresh: getAllTransactions,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              // right: 8.0,
                              left: 8.0,
                              bottom: 60,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('  '),
                                Column(
                                  children: List.generate(
                                    _trasansactionsByDate.length,
                                    (index) => TransactionsWidget(
                                      user: widget.user,
                                      trasansactionsByDate:
                                          _trasansactionsByDate[index],
                                      //user: widget.user,
                                      //groupe: widget.groupe,
                                      //tontine: widget.tontine,
                                    ),
                                    //(index) => Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onVerticalDragCancel: () {
                          getAllTransactions();
                          Functions.showLoadingSheet(ctxt: context);
                          Future.delayed(const Duration(seconds: 5)).then((_) {
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: 'Mise à jour de la liste effectuée.',
                              backgroundColor: Palette.appPrimaryColor,
                            );
                          });
                        },
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              // right: 8.0,
                              left: 8.0,
                              bottom: 60,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('  '),
                                Column(
                                  children: List.generate(
                                    _trasansactionsByDate.length,
                                    (index) => TransactionsWidget(
                                      user: widget.user,
                                      trasansactionsByDate:
                                          _trasansactionsByDate[index],
                                      //user: widget.user,
                                      //groupe: widget.groupe,
                                      //tontine: widget.tontine,
                                    ),
                                    //(index) => Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
            : Center(
                child: LoadingContainer(),
              ),
      ),
    );
    //);
  }
}
