import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytine/functions/functions.dart';
import 'package:moneytine/remote_services/remote_services.dart';
import 'package:moneytine/screens/single_tontine/widgets/export_widgets.dart';

import '../../../models/single_group_data.dart';
import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../style/palette.dart';
import 'group_user_contribution.dart';
import 'register_user_versement.dart';

class MemberInfosContainer extends StatefulWidget {
  const MemberInfosContainer({
    super.key,
    required this.groupe,
    required this.tontine,
    required this.user,
    required this.data,
    required this.currentUser,
  });
  final Tontine tontine;
  final Groupe groupe;
  final MyUser user;
  final SingleGroupData data;
  final MyUser currentUser;

  @override
  State<MemberInfosContainer> createState() => _MemberInfosContainerState();
}

class _MemberInfosContainerState extends State<MemberInfosContainer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(
                top: 5.0,
                bottom: 15.0,
              ),
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              widget.user.fullName,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          rowInfos(
              text1: 'Nom :',
              text2: Functions.nameFormater(
                fullName: widget.data.name,
                isFirstname: true,
              )

              // onTap: () {},
              ),
          rowInfos(
            text1: 'Prénoms :',
            text2: Functions.nameFormater(
              fullName: widget.data.name,
              isFirstname: false,
            ),
            // onTap: () {},
          ),
          rowInfos(
            text1: 'Email :',
            text2: widget.data.email,
            // onTap: () {},
          ),
          rowInfos(
            text1: 'Part de contribution :',
            text2:
                '${widget.data.part} => ${widget.data.part * widget.tontine.contribution}',
            // onTap: () {},
          ),
          rowInfos(
            text1: 'Gain après retrait:',
            text2:
                '${(widget.tontine.contribution * double.parse(widget.tontine.numberOfType.toString()) * widget.data.part)} FCFA',
            //onTap: () {},
          ),
          rowInfos(
            text1: 'Statut de retrait :',
            text2: 'Effectuée',
            // onTap: () {},
          ),
          /* rowInfos(
            text1: 'Historique des contributions :',
            text2: 'Voir',
            isHistory: true,
            onTap: () {
              // print('contribution historique ');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GroupUserContribution(
                  groupe: widget.groupe,
                  tontine: widget.tontine,
                  user: widget.user,
                );
              }));
            },
          ), */
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GenerateGroupeButton(
                  isGenerate: true,
                  text: 'Faire un Retrait',
                  color: Palette.appPrimaryColor,
                  icon: CupertinoIcons.arrow_up,
                  onTap: retrait,
                ),
                const SizedBox(
                  width: 4,
                ),
                GenerateGroupeButton(
                  isGenerate: true,
                  text: 'Faire un versement',
                  color: Palette.appSecondaryColor,
                  icon: CupertinoIcons.arrow_down,
                  onTap: versement,
                ),
                const SizedBox(
                  width: 4,
                ),
                GenerateGroupeButton(
                  isGenerate: true,
                  text: 'Retirer ce membre',
                  color: Palette.greyColor,
                  icon: CupertinoIcons.minus,
                  onTap: () {
                    if (widget.currentUser.id == widget.tontine.creatorId) {
                      // do something /////////////////////////
                      if (widget.tontine.isActive == 1) {
                        removeUser();
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Veuillez reactivée la tontine !',
                          backgroundColor: Palette.appPrimaryColor,
                        );
                      }
                      /////////////////////////////////////////
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Action non autorisée !',
                        backgroundColor: Palette.appPrimaryColor,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          GroupUserContribution(
            groupe: widget.groupe,
            tontine: widget.tontine,
            user: widget.user,
          ),
          /* Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomButton(
                color: Palette.appPrimaryColor,
                width: double.infinity,
                height: 45,
                radius: 50,
                isSetting: true,
                fontsize: 14,
                text: 'Faire un retrait',
                onPress: () {
                  if (widget.currentUser.id == widget.tontine.creatorId) {
                    // todo something///////////////////////////
                    if (widget.tontine.isActive == 1) {
                      //////////////// on peut faire retrait///////////////////
                      ///

                      ///
                      /////////////////////////////////////////////////////////
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Veuillez réactivée la tontine !',
                        backgroundColor: Palette.appPrimaryColor,
                      );
                    }
                    //////////////////
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Action non autorisée !',
                      backgroundColor: Palette.appPrimaryColor,
                    );
                  }
                }),
          ), */
          /* Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomButton(
              color: Palette.appSecondaryColor,
              width: double.infinity,
              height: 45,
              isSetting: true,
              fontsize: 14,
              radius: 50,
              text: 'Enregistrer un versement',
              onPress: () {
                if (widget.currentUser.id == widget.tontine.creatorId) {
                  if (widget.tontine.isActive == 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterUserVersement(
                            groupe: widget.groupe,
                            tontine: widget.tontine,
                            user: widget.user,
                          );
                        },
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Veuillez réactivée la tontine !',
                      backgroundColor: Palette.appPrimaryColor,
                    );
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: 'Action non autorisée !',
                    backgroundColor: Palette.appPrimaryColor,
                  );
                }
              },
            ),
          ), */
          /*  Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomButton(
              color: Palette.greyColor,
              width: double.infinity,
              height: 45,
              radius: 50,
              isSetting: true,
              fontsize: 14,
              text: 'Retirer ce membre',
              onPress: () {
                if (widget.currentUser.id == widget.tontine.creatorId) {
                  // do something /////////////////////////
                  if (widget.tontine.isActive == 1) {
                    removeUser();
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Veuillez reactivée la tontine !',
                      backgroundColor: Palette.appPrimaryColor,
                    );
                  }
                  /////////////////////////////////////////
                } else {
                  Fluttertoast.showToast(
                    msg: 'Action non autorisée !',
                    backgroundColor: Palette.appPrimaryColor,
                  );
                }
              },
            ),
          ), */
        ],
      ),
    );
  }

  Padding rowInfos({
    required String text1,
    required String text2,
    bool isHistory = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text1),
          !isHistory
              ? Text(
                  text2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              : TextButton(
                  onPressed: onTap,
                  child: Container(
                    width: 60,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Palette.appPrimaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Voir',
                        style: TextStyle(
                          color: Palette.appPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }

  void versement() {
    if (widget.currentUser.id == widget.tontine.creatorId) {
      if (widget.tontine.isActive == 1) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return RegisterUserVersement(
                groupe: widget.groupe,
                tontine: widget.tontine,
                user: widget.user,
              );
            },
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Veuillez réactivée la tontine !',
          backgroundColor: Palette.appPrimaryColor,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Action non autorisée !',
        backgroundColor: Palette.appPrimaryColor,
      );
    }
  }

  void removeUser() async {
    Functions.showLoadingSheet(ctxt: context);
    int response = await RemoteServices().deleteUserToGroup(
      groupId: widget.groupe.id,
      userId: widget.user.id!,
    );
    if (response == 200 || response == 201) {
      setState(() {
        widget.groupe.membrsId
            .removeWhere((element) => element == widget.user.id);
      });
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: 'Membre retiré !',
          backgroundColor: Palette.appPrimaryColor,
        );
        Navigator.pop(context);
      });
    } else {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: 'Ce membre ne peut-être retiré !',
          backgroundColor: Palette.appPrimaryColor,
        );
        Navigator.pop(context);
      });
    }
  }

  void retrait() {
    if (widget.currentUser.id == widget.tontine.creatorId) {
      // todo something///////////////////////////
      if (widget.tontine.isActive == 1) {
        //////////////// on peut faire retrait///////////////////
        ///
        print('retrait stard !');

        ///
        /////////////////////////////////////////////////////////
      } else {
        Fluttertoast.showToast(
          msg: 'Veuillez réactivée la tontine !',
          backgroundColor: Palette.appPrimaryColor,
        );
      }
      //////////////////
    } else {
      Fluttertoast.showToast(
        msg: 'Action non autorisée !',
        backgroundColor: Palette.appPrimaryColor,
      );
    }
  }
}
