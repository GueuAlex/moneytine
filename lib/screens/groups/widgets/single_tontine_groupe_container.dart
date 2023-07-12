import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../functions/functions.dart';
import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
import '../../../style/palette.dart';
import '../../single_tontine/widgets/export_widgets.dart';
//import 'export_widgets.dart';

class SingleTontineGroupeContainer extends StatefulWidget {
  const SingleTontineGroupeContainer({
    super.key,
    required this.tontine,
    required this.user,
  });

  final Tontine tontine;
  final MyUser user;

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
                // Functions.showLoadingSheet(ctxt: context);
                generateGroup(
                  userId: widget.user.id,
                  creatorId: widget.tontine.creatorId,
                  tontineId: widget.tontine.id,
                );
              },
            ),
    );
  }

  /*  void generateGroup({
    required int? userId,
    required int creatorId,
    required int tontineId,
  }) async {
    if (userId == creatorId) {
      Functions.showLoadingSheet(ctxt: context);
      Groupe newGroupe = Groupe(
        nom: 'Groupe_${(widget.tontine.groupes.length + 1)}',
        // cretat: DateTime.now(),
      );

      String groupeName = 'Groupe_${(widget.tontine.groupes.length + 1)}';
      var response = await RemoteServices().postGeneratGroupeDetails(
        api: 'groups',
        tontineId: tontineId,
        groupeName: groupeName,
      );
      if (response != null) {
        Future.delayed(const Duration(seconds: 3)).then((value) {
          setState(() {
            widget.tontine.groupes.add(newGroupe);
          });
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: 'Ajouté !',
            backgroundColor: Palette.appPrimaryColor,
          );
        });
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: 'Veuillez réessayer !',
          backgroundColor: Palette.appPrimaryColor,
        );
      }
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Vous n\'est pas l\'administrateur de cette tontine !',
        backgroundColor: Palette.appPrimaryColor,
      );
    }
  } */

  //////////////////// function to generate group //////////////////////////
  ///
  ///
  ///
  void generateGroup({
    required int? userId,
    required int creatorId,
    required int tontineId,
  }) async {
    if (userId == creatorId) {
      Functions.showLoadingSheet(ctxt: context);

      String groupeName = 'Groupe_${(widget.tontine.groupes.length + 1)}';
      var response = await RemoteServices().postGeneratGroupeDetails(
        api: 'groups',
        tontineId: tontineId,
        groupeName: groupeName,
      );
      if (response != null) {
        Future.delayed(const Duration(seconds: 3)).then((value) async {
          Groupe? g = await RemoteServices().getSingleGroupe(
            groupeId: int.parse(response),
          );
          Groupe newGroupe = Groupe(
            nom: groupeName,
            id: int.parse(response),
          );
          if (g != null) {
            //print('difffff');
            setState(() {
              widget.tontine.groupes.add(g);
            });
          }
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: 'Ajouté !',
            backgroundColor: Palette.appPrimaryColor,
          );
        });
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: 'Veuillez réessayer !',
          backgroundColor: Palette.appPrimaryColor,
        );
      }
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Vous n\'est pas l\'administrateur de cette tontine !',
        backgroundColor: Palette.appPrimaryColor,
      );
    }
  }
}
