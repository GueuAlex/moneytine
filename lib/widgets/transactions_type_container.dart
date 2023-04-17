import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/models/money_transaction.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/remote_services/remote_services.dart';
import 'package:shimmer/shimmer.dart';

import '../style/palette.dart';

class TransactionsTypeContainer extends StatefulWidget {
  const TransactionsTypeContainer({
    super.key,
    //required this.transactionType,
    required this.color,
    required this.mTransactions,
    //required this.groupe,
    //required this.tontine,
    //required this.user,
    required this.lastIndex,
    required this.index,
  });
  //final String transactionType;
  final Color color;
  final MoneyTransaction mTransactions;
  //final Tontine tontine;
  // final Groupe groupe;
  //final User user;
  final int lastIndex;
  final int index;

  @override
  State<TransactionsTypeContainer> createState() =>
      _TransactionsTypeContainerState();
}

class _TransactionsTypeContainerState extends State<TransactionsTypeContainer> {
  /////////////////////// tontine ////////////////////////////
  ///
  ///
  Tontine? _tontine;
  MyUser? _user;

  getTontineById() async {
    Tontine? tontine = await RemoteServices()
        .getSingleTontine(id: widget.mTransactions.tontineId);
    if (tontine != null) {
      setState(() {
        _tontine = tontine;
      });
    }
  }

  getUserById() async {
    MyUser? user =
        await RemoteServices().getSingleUser(id: widget.mTransactions.userId);
    if (user != null) {
      setState(() {
        _user = user;
      });
    }
  }

  @override
  void initState() {
    getTontineById();
    getUserById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _user != null && _tontine != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Container(
                      width: 60,
                      height: 20,
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            widget.mTransactions.type.toLowerCase(),
                            style: TextStyle(
                              color: widget.color,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 28),
                    child: Text(
                      widget.mTransactions.hours.substring(0, 5),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 28.0,
                ),
                child: Text(
                  _tontine!.tontineName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 8.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.person_fill,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _user!.fullName,
                            style: const TextStyle(color: Palette.greyColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                        right: 2.0,
                        left: 2.0,
                      ),
                      width: 70,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Palette.greyColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            '${widget.mTransactions.amunt} CFA',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 2.0,
              ),
              widget.index + 1 == widget.lastIndex
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 50, right: 50.0, top: 5.0, bottom: 5.0),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.5),
                        thickness: 1.5,
                      ),
                    ),
            ],
          )
        : Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade300,
            child: const TransactionsShimmer());
  }
}

class TransactionsShimmer extends StatelessWidget {
  const TransactionsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.grey,
    );
  }
}
