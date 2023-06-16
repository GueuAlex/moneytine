import 'package:flutter/material.dart';

import '../../../models/money_transaction.dart';
import '../../../models/tontine.dart';
import '../../../models/transation_by_date.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
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
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        // right: 8.0,
                        left: 8.0,
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
                  )
            : Center(
                child: LoadingContainer(),
              ),
      ),
    );
    //);
  }
}
