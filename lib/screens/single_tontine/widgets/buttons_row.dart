import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../functions/functions.dart';
import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
import '../../../style/palette.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/generate_groupe_button.dart';
import '../../groups/groups_screen.dart';
import '../../modify_tontine/mdify_tontine.dart';
import '../../my_tontines/mes_tontines.dart';
import '../single_tontine.dart';

class ButtonsRow extends StatefulWidget {
  const ButtonsRow({
    super.key,
    required this.widget,
    required this.user,
  });

  final SingleTontine widget;
  final MyUser user;

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
                  msg:
                      'Cette action est uniquement reservée qu\'a l\'administration',
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
              if (widget.widget.tontine.creatorId == widget.widget.user.id) {
                if (widget.widget.tontine.isActive == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return GroupsScreen(
                      tontine: widget.widget.tontine,
                      user: widget.widget.user,
                    );
                  }));
                } else {
                  Fluttertoast.showToast(
                    msg: 'Veuillez réactivé la tontine avant',
                    backgroundColor: Palette.appPrimaryColor,
                  );
                }
              } else {
                Fluttertoast.showToast(
                  msg:
                      'Cette action est uniquement reservée qu\'a l\'administration',
                  backgroundColor: Palette.appPrimaryColor,
                );
              }
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
                //Functions.showLoadingSheet(ctxt: context);
                /* deleteTontine(
                  tontineId: widget.widget.tontine.id,
                  context: context,
                ); */
                showModal(
                  isDeleteProcess: true,
                  onTap: () => deleteTontine(
                    tontineId: widget.widget.tontine.id,
                    context: context,
                  ),
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
    Functions.showLoadingSheet(ctxt: context);
    var responsse = await RemoteServices().deletSingleTontine(id: tontineId);
    if (responsse == 500) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Cette tontine ne peut-être supprimée !',
        backgroundColor: Palette.appPrimaryColor,
      );
    } else {
      setState(() {
        currentUSerTontineList
            .removeWhere((element) => element == widget.widget.tontine);
      });

      //getUserOwnTontineList();

      Fluttertoast.showToast(
        msg: 'Tontine supprimée !',
        backgroundColor: Palette.appPrimaryColor,
      );

      // ignore: use_build_context_synchronously
      Future.delayed(const Duration(seconds: 3)).then(
        (_) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return MesTontinesScreen(
                //tontineList: currentUSerTontineList,
                user: widget.widget.user,
              );
            },
          ), (route) => false);
        },
      );
    }
  }

  showModal({required bool isDeleteProcess, required Function onTap}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 200,
          decoration: const BoxDecoration(
            color: Palette.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: ConfirmSheet(isDeleteProcess: isDeleteProcess, onTap: onTap),
        );
      },
    );
  }

  void getUserOwnTontineList() async {
    List<Tontine?> tontineList1 = await RemoteServices()
        .getCurrentUserTontineList(id: int.parse(widget.user.id.toString()));
    if (tontineList1.isNotEmpty) {
      //currentUSerTontineList.clear();
      for (var element in tontineList1) {
        setState(() {
          // tontineList.add(element!);
          setState(() {
            currentUSerTontineList.add(element!);
          });
        });
      }
    }
  }
}

class ConfirmSheet extends StatelessWidget {
  final bool isDeleteProcess;
  final Function onTap;
  const ConfirmSheet({
    super.key,
    required this.isDeleteProcess,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(top: 5),
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              color: Palette.greyColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                isDeleteProcess
                    ? 'Souhaitez vous vraiment supprimer cette tontine ?\nCette action est irréversible'
                    : 'Souhaitez vous suspendre cette tontine?\nVous pouvez la réactivée plutard',
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
                child: Column(
                  children: [
                    CustomButton(
                      isSetting: true,
                      fontsize: 13,
                      color: Palette.appPrimaryColor,
                      width: double.infinity,
                      height: 35,
                      radius: 50,
                      text: 'Confirmer',
                      onPress: () => onTap(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      isSetting: true,
                      fontsize: 13,
                      color: Palette.primaryColor,
                      width: double.infinity,
                      height: 35,
                      radius: 50,
                      text: 'Annuler',
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              //Container()
            ],
          ),
        )
      ],
    );
  }
}
