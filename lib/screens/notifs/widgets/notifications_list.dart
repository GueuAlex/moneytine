import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/models/notification_models.dart';
import 'package:moneytine/models/transation_by_date.dart';

import '../../../style/palette.dart';
import 'paiement_notification.dart';
import 'rapel_notification.dart';
import 'reception_notification.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({
    super.key,
    required this.notificationModelByDate,
  });

  final DataByDate<NotificationModel> notificationModelByDate;

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
            DateFormat('dd MMMM yyyy', 'fr')
                .format(widget.notificationModelByDate.date),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Palette.greyColor.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Column(
          children: List.generate(
            widget.notificationModelByDate.data.length,
            (index) => widget.notificationModelByDate.data[index].type ==
                    "Versement"
                ? PaiementNotication(
                    notificationModel:
                        widget.notificationModelByDate.data[index],
                  )
                : widget.notificationModelByDate.data[index].type == "Retrait"
                    ? ReceptionNotication(
                        notificationModel:
                            widget.notificationModelByDate.data[index],
                      )
                    : widget.notificationModelByDate.data[index].type ==
                            "Rappel"
                        ? RapelNotification(
                            notificationModel:
                                widget.notificationModelByDate.data[index],
                          )
                        : Container(),
          ),
        ),
      ],
    );
  }
}
