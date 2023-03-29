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
      width: double.infinity,
      height: 120,
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
            padding: const EdgeInsets.all(8.0),
            //color: Colors.amber,
            height: 55,
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Votre code d\'invitation  ',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      Text(
                        tontine.uniqueCode.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            height: 1.2,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                      //padding: const EdgeInsets.only(bottom: 10.0),
                      height: 28,
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
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              //color: Colors.black,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: CheickContainer(
                      text1: 'En retard',
                      text2: 'membres',
                      numberOf: '2 ',
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: 1,
                    color: Colors.grey,
                  ),
                  const Expanded(
                    child: CheickContainer(
                      text1: 'A jour',
                      text2: 'membres',
                      numberOf: '5 ',
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
