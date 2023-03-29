import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../style/palette.dart';

class PaiementNotication extends StatelessWidget {
  const PaiementNotication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 50,
      margin: const EdgeInsets.only(top: 5.0),
      // padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      //color: Colors.red,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 25, left: 25),
            width: 100,
            // height: 120,
            child: Container(
              padding: const EdgeInsets.all(13.0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Palette.appSecondaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                CupertinoIcons.arrow_up,
                color: Palette.appSecondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(right: 8.0, left: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Paiment d\'un montant de ',
                      style: const TextStyle(
                        //fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: '70000 FCFA ',
                          style: TextStyle(
                            color: Palette.appPrimaryColor,
                            fontSize: 18,
                          ),
                        ),
                        const TextSpan(
                          text: 'pour',
                          style: TextStyle(),
                        ),
                        const TextSpan(
                          text: ' tontineName ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              DateFormat(' bien reçu ').format(DateTime.now()),
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      DateFormat('à HH:mm').format(DateTime.now()),
                      style: const TextStyle(
                        color: Palette.greyColor,
                        fontSize: 12,
                      ),
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
