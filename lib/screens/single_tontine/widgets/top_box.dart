import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../functions/functions.dart';
import '../../../models/tontine.dart';
import '../../../style/palette.dart';
import 'cheick_container.dart';

class TopBox extends StatelessWidget {
  const TopBox({
    super.key,
    required this.tontine,
  });

  final Tontine tontine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      width: double.infinity,
      height: 110,
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
                    child: Column(
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
                          tontine.uniqueCode.toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              height: 1.2,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Container(
                  width: 80,
                  padding: const EdgeInsets.only(left: 8.0),
                  decoration: BoxDecoration(
                    color: Palette.appPrimaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5.0),
                        //padding: const EdgeInsets.only(bottom: 10.0),
                        //height: 28,
                        width: 28,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.secondaryColor),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Functions.copyToClipboard(
                                  text: tontine.uniqueCode.toString());
                              Fluttertoast.showToast(
                                msg: 'Copié !',
                                backgroundColor: Palette.appPrimaryColor,
                              );
                            },
                            icon: const Icon(
                              Icons.copy,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Copié',
                        style: TextStyle(
                          color: Palette.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 2.0,
          ),
          Expanded(
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
                        text1: 'En retard',
                        text2: 'membres',
                        numberOf: '2 ',
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
                        paddingLeft: 8.0,
                        paddingRigth: 8.0,
                        text1: 'A jour',
                        text2: 'membres',
                        numberOf: '5 ',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
