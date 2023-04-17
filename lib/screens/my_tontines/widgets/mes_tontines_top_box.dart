import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/tontine.dart';
import '../../../style/palette.dart';
import '../mes_tontines.dart';
import 'jeparticipe.dart';
import 'jorganise.dart';

class MesTontinesTopBox extends StatelessWidget {
  const MesTontinesTopBox({
    super.key,
    required this.widget,
  });

  final MesTontinesScreen widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      //bottom: 50,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(right: 50.0, left: 50.0, top: 90),
        width: double.infinity,
        height: 130,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  if (allTontineWhereCurrentUserParticipe.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return JeParticipe(
                            tontineList: allTontineWhereCurrentUserParticipe,
                            user: widget.user,
                          );
                        },
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Veuillez rejoindre avant',
                      backgroundColor: Palette.appPrimaryColor,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    left: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Palette.greyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Vous participez à ',
                              style:
                                  TextStyle(color: Palette.greySecondaryColor),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    allTontineWhereCurrentUserParticipe.length
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    allTontineWhereCurrentUserParticipe
                                                .length <=
                                            1
                                        ? ' tontine'
                                        : 'tontines',
                                    style: const TextStyle(
                                        color: Palette.greySecondaryColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.secondaryColor),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            /* Divider(
              color: Palette.greyColor.withOpacity(0.5),
              thickness: 1.5,
            ), */
            const SizedBox(
              height: 4.0,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (currentUSerTontineList.isNotEmpty) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Jorganise(
                        tontineList: currentUSerTontineList,
                        user: widget.user,
                      );
                    }));
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Veuillez créer une tontine avant',
                      backgroundColor: Palette.appPrimaryColor,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    left: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Palette.greyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Vous organisez ',
                              style:
                                  TextStyle(color: Palette.greySecondaryColor),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    currentUSerTontineList.length.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    allTontineWhereCurrentUserParticipe
                                                .length <=
                                            1
                                        ? ' tontine'
                                        : 'tontines',
                                    style: const TextStyle(
                                        color: Palette.greySecondaryColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.secondaryColor),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
