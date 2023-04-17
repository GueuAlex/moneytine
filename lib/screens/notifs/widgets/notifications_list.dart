import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../style/palette.dart';
import 'paiement_notification.dart';
import 'rapel_notification.dart';
import 'reception_notification.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({
    super.key,
  });

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 15.0),
          child: Text(
            DateFormat('EE MM yyyy', 'fr').format(DateTime.now()),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Palette.greyColor.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Column(
          children: const [
            RapelNotification(),
            PaiementNotication(),
            ReceptionNotication(),
          ],
        ),
      ],
    );
  }
}
