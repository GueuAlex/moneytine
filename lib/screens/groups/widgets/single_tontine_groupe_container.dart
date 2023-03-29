import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/style/palette.dart';

import '../../../functions/functions.dart';
import '../../../models/tontine.dart';
import '../../single_tontine/widgets/export_widgets.dart';
//import 'export_widgets.dart';

class SingleTontineGroupeContainer extends StatefulWidget {
  const SingleTontineGroupeContainer({
    super.key,
    required this.tontine,
    required this.user,
  });

  final Tontine tontine;
  final User user;

  @override
  State<SingleTontineGroupeContainer> createState() =>
      _SingleTontineGroupeContainerState();
}

class _SingleTontineGroupeContainerState
    extends State<SingleTontineGroupeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
        bottom: 20.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: widget.tontine.groupes.isNotEmpty
          ? ListGroup(
              tontine: widget.tontine,
              user: widget.user,
            )
          : TontineHasNotGroup(
              onTap: () {
                Functions.showLoadingSheet(ctxt: context);
                generateGroup(
                  userId: widget.user.id,
                  creatorId: widget.tontine.creatorId,
                );
              },
            ),
    );
  }

  void generateGroup({
    required int? userId,
    required int creatorId,
  }) {
    if (userId == creatorId) {
      Groupe newGroupe = Groupe(
        nom: 'Groupe_${(widget.tontine.groupes.length + 1)}',
        //cretat: DateTime.now(),
      );
      Future.delayed(const Duration(seconds: 3)).then((value) {
        setState(() {
          widget.tontine.groupes.add(newGroupe);
        });
        Navigator.pop(context);
      });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Vous n\'est pas l\'administrateur de cette tontine !',
        backgroundColor: Palette.appPrimaryColor,
      );
    }
  }
}
