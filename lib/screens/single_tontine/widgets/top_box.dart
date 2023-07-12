import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../functions/functions.dart';
import '../../../models/tontine.dart';
import '../../../models/tontine_members_status.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
import '../../../style/palette.dart';
import 'cheick_container.dart';
import 'status_sheet.dart';

class TopBox extends StatefulWidget {
  const TopBox({
    super.key,
    required this.tontine,
    required this.user,
  });

  final Tontine tontine;
  final MyUser user;

  @override
  State<TopBox> createState() => _TopBoxState();
}

class _TopBoxState extends State<TopBox> {
  bool isCreator = false;
  /////////////////////////////
  ///
  TontineMembersStatus tontineMembersStatus = TontineMembersStatus(
    update: [],
    outdated: [],
  );
  //////////////////////////////////////
  ///
  getTontineMembersStatus() async {
    TontineMembersStatus? status =
        await RemoteServices().getTontineMemberStatus(
      id: widget.tontine.id,
    );
    if (status != null) {
      setState(() {
        tontineMembersStatus = status;
      });
    }
  }

  @override
  void initState() {
    if (widget.user.id == widget.tontine.creatorId) {
      //print("object");
      setState(() {
        isCreator = true;
      });
    }
    getTontineMembersStatus();
    super.initState();
  }

  ///
  ///////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      width: double.infinity,
      //height: widget.user.id == widget.tontine.id ? 110 : 65,
      height: isCreator ? 110 : 65,
      //height: 65,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.0),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1), // déplace l'ombre vers le bas
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // déplace l'ombre vers le haut
          )
        ],
        color: Palette.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            //color: Colors.red,
            padding: const EdgeInsets.only(
              right: 8.0,
              left: 8.0,
              top: 8.0,
            ),
            //color: Colors.amber,
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      left: 8.0,
                      top: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Palette.greyColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Votre code d\'invitation  ',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              widget.tontine.uniqueCode.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.2,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        ///////
                        ///
                        ///
                        ///

                        //////////
                        ///
                        ///
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(left: 4.0),
                  padding: const EdgeInsets.only(
                    left: 4.0,
                    right: 4.0,
                    top: 4,
                    bottom: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Palette.appPrimaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5.0),
                        //padding: const EdgeInsets.only(bottom: 15.0),
                        //height: 28,
                        width: 28,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.secondaryColor,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Functions.copyToClipboard(
                                  text: widget.tontine.uniqueCode.toString());
                              Fluttertoast.showToast(
                                msg: 'Copié !',
                                backgroundColor: Palette.appPrimaryColor,
                              );
                            },
                            icon: const Icon(
                              Icons.copy,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Copier',
                        style: TextStyle(
                          color: Palette.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 2.0,
          ),
          //widget.user.id == widget.tontine.id
          isCreator
              ? Expanded(
                  child: Container(
                    //color: Colors.black,
                    decoration: const BoxDecoration(
                        /* border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ), */

                        ),
                    child: Row(
                      children: [
                        Expanded(
                          //child: FittedBox(
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 8.0,
                              right: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: Palette.greyColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: const EdgeInsets.only(
                              top: 3.0,
                              right: 8.0,
                              left: 8.0,
                            ),
                            child: CheickContainer(
                              onTap: () {
                                _showBottomSheet(
                                  context: context,
                                  uersList: tontineMembersStatus.outdated,
                                );
                              },
                              text1: 'En retard',
                              text2: 'membres',
                              numberOf:
                                  '${tontineMembersStatus.outdated.length.toString()} ',
                              paddingLeft: 8.0,
                              paddingRigth: 8.0,
                            ),
                          ),
                          //),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 8.0,
                            ),
                            padding: const EdgeInsets.only(
                              top: 3.0,
                              right: 8.0,
                              left: 8.0,
                            ),
                            decoration: BoxDecoration(
                              color: Palette.greyColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: CheickContainer(
                              onTap: () {
                                _showBottomSheet(
                                  context: context,
                                  uersList: tontineMembersStatus.update,
                                );
                              },
                              paddingLeft: 8.0,
                              paddingRigth: 8.0,
                              text1: 'A jour',
                              text2: 'membres',
                              numberOf:
                                  '${tontineMembersStatus.update.length.toString()} ',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void _showBottomSheet({
    required BuildContext context,
    required List<MyUser> uersList,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Palette.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: StatusSheet(
            uersList: uersList,
            tontine: widget.tontine,
          ),
        );
      },
    );
  }
}
