import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../functions/functions.dart';
import '../../../models/notification_models.dart';
import '../../../style/palette.dart';

class PaiementNotication extends StatelessWidget {
  const PaiementNotication({
    super.key,
    required this.notificationModel,
  });

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    String montant = Functions.addSpaceAfterThreeDigits(
      notificationModel.amount.toString(),
    );
    return Container(
      width: double.infinity,
      //height: 50,
      margin: const EdgeInsets.only(
        top: 5.0,
        right: 8.0,
        left: 8.0,
      ),
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
              //padding: const EdgeInsets.all(13.0),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Palette.appSecondaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                CupertinoIcons.arrow_up,
                color: Palette.appSecondaryColor,
                size: 14,
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
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${montant} FCFA ',
                          style: TextStyle(
                            color: Palette.appPrimaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(
                          text: 'pour',
                          style: TextStyle(),
                        ),
                        TextSpan(
                          text: ' ${notificationModel.tontineName} ',
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
                      notificationModel.hour.substring(0, 5),
                      style: const TextStyle(
                        color: Palette.greyColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
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
