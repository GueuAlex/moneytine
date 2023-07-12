//import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/functions/functions.dart';
import 'package:moneytine/screens/my_tontines/mes_tontines.dart';

import '../../models/tontine.dart';
import '../../models/user.dart';
import '../../style/palette.dart';
import 'widgets/buttons_row.dart';
import 'widgets/single_tontine_header.dart';
import 'widgets/single_tontine_last_transactions.dart';
import 'widgets/tontine_member_contribution.dart';
import 'widgets/top_box.dart';

//import 'widgets/export_widgets.dart';

class SingleTontine extends StatefulWidget {
  const SingleTontine({
    super.key,
    required this.tontine,
    required this.user,
    this.isFiret = false,
  });
  final Tontine tontine;
  final bool isFiret;
  final MyUser user;

  @override
  State<SingleTontine> createState() => _SingleTontineState();
}

class _SingleTontineState extends State<SingleTontine> {
  bool isShimmer = false;
  bool isCreator = false;
  @override
  void initState() {
    if (widget.user.id == widget.tontine.creatorId) {
      setState(() {
        isCreator = true;
      });
    }
    setState(() {
      isShimmer = widget.isFiret;
    });

    Future.delayed(const Duration(seconds: 3)).then((value) {
      setState(() {
        isShimmer = false;
      });
      // Navigator.pop(context);
    });
    Functions().sendPaiementRemember(
      tontine: widget.tontine,
      user: widget.user,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 20,
        leading: widget.isFiret
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return MesTontinesScreen(user: widget.user);
                  }), (route) => false);
                },
                icon: Icon(
                  Platform.isIOS
                      ? CupertinoIcons.chevron_back
                      : CupertinoIcons.arrow_left,
                  color: Palette.whiteColor,
                ),
              )
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Platform.isIOS
                      ? CupertinoIcons.chevron_back
                      : CupertinoIcons.arrow_left,
                  color: Palette.whiteColor,
                ),
              ),
        backgroundColor: Palette.secondaryColor,
        title: Text(widget.tontine.tontineName),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleTontineHeader(tontine: widget.tontine),
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 250,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: isCreator
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: ButtonsRow(
                            widget: widget,
                            user: widget.user,
                          ),
                        )
                      : Container(),
                ),
                Expanded(
                  /////////// it's last transactions right now ///////////////
                  child: widget.user.id == widget.tontine.creatorId
                      ? SingleTontineLastTransactions(
                          user: widget.user,
                          tontine: widget.tontine,
                        )
                      : TontineMemberContribution(
                          //groupe: 0,
                          tontine: widget.tontine,
                          user: widget.user,
                        ),
                  ////////////////////////////////////////////////////////////
                )
              ],
            ),
            Positioned(
              //top: 20,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 55.0, left: 55.0, top: 130),
                child: TopBox(
                  tontine: widget.tontine,
                  user: widget.user,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
