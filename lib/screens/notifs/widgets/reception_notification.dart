import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../style/palette.dart';

class ReceptionNotication extends StatelessWidget {
  const ReceptionNotication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 50,
      margin: const EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0),
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      //color: Colors.red,
      decoration: BoxDecoration(
        color: Palette.greyColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 31, left: 31),
            width: 100,
            // height: 120,
            child: Container(
                // padding: const EdgeInsets.all(13.0),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Palette.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.0)),
                child: const Icon(
                  CupertinoIcons.arrow_down,
                  color: Palette.primaryColor,
                  size: 14,
                )),
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
                      text: 'Reception d\'un montant de ',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: '200000 FCFA ',
                          style: TextStyle(
                            color: Palette.appPrimaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(
                          text: 'de',
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
