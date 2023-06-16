//import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    setState(() {
      isShimmer = widget.isFiret;
    });

    Future.delayed(const Duration(seconds: 3)).then((value) {
      setState(() {
        isShimmer = false;
      });
      // Navigator.pop(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: widget.isFiret
            ? Container()
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
                  child: widget.user.id == widget.tontine.id
                      ? ButtonsRow(
                          widget: widget,
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
