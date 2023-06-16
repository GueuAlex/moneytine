import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../functions/firebase_fcm.dart';
import '../../../functions/functions.dart';
import '../../../models/money_transaction.dart';
import '../../../models/notification_models.dart';
import '../../../models/single_group_data.dart';
import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
import '../../../style/palette.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/generate_groupe_button.dart';
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
  bool retraitExiste = false;
  double montantSolder = 0;
  @override
  void initState() {
    verify();
    super.initState();
  }

  verify() async {
    List<MoneyTransaction> tab =
        await Functions.getThisUSerTransactionsListByGroupId(
            groupId: widget.groupe.id, userId: widget.user.id!);
    if (retraitExist(tab: tab)) {
      setState(() {
        retraitExiste = true;
      });
    }

    ///////////////////// calcul de montant soldé//////////////////////////
    ///
    ///
    double sold = 0;
    for (var element in tab) {
      if (element.type == 'Versement') {
        sold += element.amunt;
      }
    }
    setState(() {
      montantSolder = sold;
    });
  }

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
            text2: '${widget.data.part} => ${Functions.addSpaceAfterThreeDigits(
              (widget.data.part * widget.tontine.contribution).toString(),
            )} FCFA',
            // onTap: () {},
          ),
          rowInfos(
            text1: 'Gain après retrait:',
            text2: '${Functions.addSpaceAfterThreeDigits(
              (widget.tontine.contribution *
                      double.parse(widget.tontine.numberOfType.toString()) *
                      widget.data.part)
                  .toString(),
            )} FCFA',
            //onTap: () {},
          ),
          rowInfos(
            text1: 'Montant soldé :',
            text2:
                '${Functions.addSpaceAfterThreeDigits(montantSolder.toString())} FCFA',
            // onTap: () {},
          ),
          rowInfos(
            text1: 'Statut de retrait :',
            text2: retraitExiste ? 'Effectué' : 'Non effectué',
            // onTap: () {},
          ),
          const SizedBox(height: 25),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GenerateGroupeButton(
                  isGenerate: false,
                  text: 'Retrait',
                  color: Palette.appPrimaryColor,
                  icon: CupertinoIcons.arrow_up,
                  onTap: () {
                    _showBottomSheet(context: context);
                  },
                ),
                const SizedBox(
                  width: 4,
                ),
                GenerateGroupeButton(
                  isGenerate: false,
                  text: 'Versement',
                  color: Palette.appSecondaryColor,
                  icon: CupertinoIcons.arrow_down,
                  onTap: versement,
                ),
                const SizedBox(
                  width: 4,
                ),
                GenerateGroupeButton(
                  isGenerate: false,
                  text: 'Retirer',
                  color: Palette.greyColor,
                  icon: CupertinoIcons.minus,
                  onTap: () {
                    if (widget.currentUser.id == widget.tontine.creatorId) {
                      // do something /////////////////////////
                      if (widget.tontine.isActive == 1) {
                        _showBottomSheet(context: context, isRetrait: false);
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

  void retrait() async {
    if (widget.currentUser.id == widget.tontine.creatorId) {
      // todo something///////////////////////////
      if (widget.tontine.isActive == 1) {
        //////////////// on peut faire retrait///////////////////
        ///

        Functions.showLoadingSheet(ctxt: context);
        List<MoneyTransaction> tab =
            await Functions.getThisUSerTransactionsListByGroupId(
          groupId: widget.groupe.id,
          userId: widget.user.id!,
        );
        //print(tab);
        if (tab.isNotEmpty) {
          if (retraitExist(tab: tab)) {
            ////////////
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: 'Un retrait existe déjà pour ce membre !',
              backgroundColor: Palette.appPrimaryColor,
            );
          } else {
            double gain = widget.tontine.contribution *
                double.parse(widget.tontine.numberOfType.toString()) *
                widget.data.part;
            String hours = DateFormat('HH:mm').format(DateTime.now());
            // print('retrait stard ok !');
            MoneyTransaction newTrasanction = MoneyTransaction(
              type: 'Retrait',
              amunt: gain,
              hours: hours,
              date: DateTime.now(),
              userId: widget.user.id!,
              groupeId: widget.groupe.id,
              tontineId: widget.tontine.id,
              tontineCreatorId: widget.tontine.creatorId,
            );
            int tId = await RemoteServices().postNewTransaction(
              api: 'transactions',
              mtransaction: newTrasanction,
            );
            if (tId.isNaN) {
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: 'Une erreur est subvenue !',
                backgroundColor: Palette.appPrimaryColor,
              );
            } else {
              Future.delayed(const Duration(seconds: 5)).then((value) async {
                /////////////////////////// create notif
                ///and send it
                NotificationModel newNotif = NotificationModel(
                  amount: gain,
                  recipientId: widget.user.id!,
                  type: 'Retrait',
                  tontineId: widget.tontine.id,
                  date: DateTime.now(),
                  hour: DateFormat('HH:mm').format(DateTime.now()),
                );
                var response = await RemoteServices().postNotifDetails(
                  api: 'notifications',
                  notificationModel: newNotif,
                );
                if (response != null) {
                  ///////////////////////////////////////////
                  /// envoi de notification
                  FirebaseFCM.getTokenNotificationByEmail(
                    userEmail: widget.user.email,
                  ).then(
                    (token) {
                      if (token != null) {
                        FirebaseFCM.sendNotification(
                          title: 'Transaction',
                          token: token,
                          message: 'Votre retrait a été enregistrer  👍🏻',
                        );
                        /////////////////:
                        ///
                        FirebaseFCM.updateUserIsNotifField(
                            email: widget.user.email, isNotif: true);
                      }
                    },
                  );
                } else {
                  // print('une erreur quelque part');
                }
              });

              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: 'Retrait bien enregistré !',
                backgroundColor: Palette.appPrimaryColor,
              );
            }
          }
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: 'Ce membre n\'a aucun paiement enregistré !',
            backgroundColor: Palette.appPrimaryColor,
          );
        }

        ///
        /////////////////////////////////////////////////////////
      } else {
        Navigator.pop(context);
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

  bool retraitExist({required List<MoneyTransaction> tab}) {
    bool retraitExist = false;
    for (MoneyTransaction element in tab) {
      if (element.type == 'Retrait') {
        retraitExist = true;
        break;
      }
    }
    return retraitExist;
  }

  void _showBottomSheet(
      {required BuildContext context, bool isRetrait = true}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
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
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Palette.greyColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.5),
                  child: Text(
                    ' ',
                    textAlign: TextAlign.center,
                  ),
                ),
                //const SizedBox(height: 20),
                //Options(options: _options)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: isRetrait
                            ? Text(
                                'Enregistrement d\'un retrait pour ${widget.user.fullName}',
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                'Souhaitez vous supprimer ${widget.user.fullName} ?',
                                textAlign: TextAlign.center,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomButton(
                        isSetting: true,
                        fontsize: 16,
                        color: Palette.appPrimaryColor,
                        width: double.infinity,
                        height: 40,
                        radius: 50,
                        text: 'Confirmer',
                        onPress: isRetrait ? retrait : removeUser,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: CustomButton(
                        isSetting: true,
                        fontsize: 16,
                        color: Palette.primaryColor,
                        width: double.infinity,
                        height: 40,
                        radius: 50,
                        text: 'Annuler',
                        onPress: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
