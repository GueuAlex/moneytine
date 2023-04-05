import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytine/functions/functions.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/remote_services/remote_services.dart';
import 'package:moneytine/screens/my_tontines/mes_tontines.dart';
import 'package:moneytine/screens/my_tontines/widgets/jorganise.dart';

import '../../../style/palette.dart';
import '../../../widgets/generate_groupe_button.dart';
import '../../groups/groups_screen.dart';
import '../../modify_tontine/mdify_tontine.dart';
import '../single_tontine.dart';

class ButtonsRow extends StatefulWidget {
  const ButtonsRow({
    super.key,
    required this.widget,
  });

  final SingleTontine widget;

  @override
  State<ButtonsRow> createState() => _ButtonsRowState();
}

class _ButtonsRowState extends State<ButtonsRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 5.0,
        left: 5.0,
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GenerateGroupeButton(
            icon: CupertinoIcons.pen,
            text: 'Modifier',
            color: Palette.secondaryColor,
            onTap: () {
              if (widget.widget.tontine.creatorId == widget.widget.user.id) {
                if (widget.widget.tontine.isActive == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ModifyTontineScreen(
                          tontine: widget.widget.tontine,
                          user: widget.widget.user,
                        );
                      },
                      fullscreenDialog: true,
                    ),
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: 'Veuillez réactivé la tontine avant',
                    backgroundColor: Palette.appPrimaryColor,
                  );
                }
              } else {
                Fluttertoast.showToast(
                  msg: 'Cette est uniquement reservée qu\'a l\'administration',
                  backgroundColor: Palette.appPrimaryColor,
                );
              }
            },
          ),
          const SizedBox(
            width: 5.0,
          ),
          GenerateGroupeButton(
            icon: CupertinoIcons.person_2,
            text: 'Groupes',
            color: Palette.primaryColor,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GroupsScreen(
                  tontine: widget.widget.tontine,
                  user: widget.widget.user,
                );
              }));
            },
          ),
          const SizedBox(
            width: 5.0,
          ),
          GenerateGroupeButton(
            icon: CupertinoIcons.delete,
            text: 'Supprimer',
            color: Palette.appPrimaryColor,
            onTap: () {
              if (widget.widget.user.id == widget.widget.tontine.creatorId) {
                Functions.showLoadingSheet(ctxt: context);
                deleteTontine(
                  tontineId: widget.widget.tontine.id,
                  context: context,
                );
              } else {
                Fluttertoast.showToast(
                    msg: 'Action non autorisée !',
                    backgroundColor: Palette.appPrimaryColor);
              }
            },
          ),
          const SizedBox(
            width: 5.0,
          ),
          GenerateGroupeButton(
            icon: widget.widget.tontine.isActive == 1
                ? CupertinoIcons.pause_fill
                : CupertinoIcons.play,
            text:
                widget.widget.tontine.isActive == 1 ? 'Suspendre' : 'Reprendre',
            color: Palette.appSecondaryColor,
            onTap: () {
              if (widget.widget.tontine.creatorId == widget.widget.user.id) {
                if (widget.widget.tontine.isActive == 1) {
                  //// on desactive ici
                  Functions.showLoadingSheet(ctxt: context);
                  Future.delayed(const Duration(seconds: 3))
                      .then((value) async {
                    int response = await RemoteServices()
                        .desableTontine(tontineId: widget.widget.tontine.id);
                    if (response == 200 || response == 201) {
                      setState(() {
                        widget.widget.tontine.isActive = 0;
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'Tontine suspendue',
                        backgroundColor: Palette.appPrimaryColor,
                      );
                    }
                  });
                } else {
                  ///// on active ici
                  Functions.showLoadingSheet(ctxt: context);
                  Future.delayed(const Duration(seconds: 3))
                      .then((value) async {
                    int response = await RemoteServices()
                        .enableTontine(tontineId: widget.widget.tontine.id);
                    if (response == 200 || response == 201) {
                      setState(() {
                        widget.widget.tontine.isActive = 1;
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'Reprise de la tontine',
                        backgroundColor: Palette.appPrimaryColor,
                      );
                    }
                  });
                }
              } else {
                Fluttertoast.showToast(
                    msg: "Action non autorisée !",
                    backgroundColor: Palette.appPrimaryColor);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> deleteTontine(
      {required int tontineId, required BuildContext context}) async {
    var responsse = await RemoteServices().deletSingleTontine(id: tontineId);
    if (responsse == 500) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Cette tontine ne peut-être supprimée !',
        backgroundColor: Palette.appPrimaryColor,
      );
    } else {
      currentUSerTontineList
          .removeWhere((element) => element == widget.widget.tontine);

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return MesTontinesScreen(
            //tontineList: currentUSerTontineList,
            user: widget.widget.user,
          );
        },
      ), (route) => false);
    }
  }
}
